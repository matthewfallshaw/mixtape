#!/usr/bin/env ruby

TRACKS = 5

require 'fileutils'
load File.join(File.dirname(__FILE__), '../..', '.secrets')

class Fixer
  def initialize(dir)
    Dir.chdir(dir)
  end

  def peeps
    Dir['*'].reject {|d| d.match(/^_/)}.collect {|peep| Peep.new(peep) }
  end

  def run!
    peeps.each do |peep|
      peep.process_songs!
    end
  end

  class Peep
    def initialize(peep)
      raise "Who's #{peep}?" unless NAMES[peep]

      @peep = peep

      ensure_build_directory
    end

    def process_songs!
      songs.each do |song|
        song.process!
      end
    end

    def songs
      Dir[File.join(name, "*")].collect do |s|
        Song.new(File.basename(s), self)
      end
    end

    def name
      @peep
    end

    def secret_name
      NAMES[name]
    end

    private

    def ensure_build_directory
      FileUtils.mkdir_p("_build/#{secret_name}")
    end
  end

  class Song
    def initialize(song, peep)
      @song = song
      @peep = peep
    end

    attr_reader :peep

    def process!
      copy_with_correct_name!
      clear_metadata!
      set_metadata!
    end

    def name
      @song[/^\d+/].to_i.to_s
    end

    def source_name
      @song
    end

    def source_file
      File.join(peep.name, source_name)
    end

    def file
      File.join("_build", peep.secret_name, name + File.extname(source_name))
    end

    def copy_with_correct_name!
      FileUtils.cp(source_file, file)
    end

    def clear_metadata!
      case File.extname(source_name)
      when ".mp3"
        puts `id3v2 -d #{file}`
        puts `id3v2 -s #{file}`
      when ".m4a"
        puts `AtomicParsley "#{file}" --metaEnema --overWrite`
      else
        raise "What's a #{source_name}?"
      end
    end

    def set_metadata!
      case File.extname(source_name)
      when ".mp3"
        puts `id3v2 -a "#{peep.secret_name}" -t #{name} -A #{name} -c #{pwgen} #{file}`
      when ".m4a"
        puts `AtomicParsley "#{file}" --artist #{peep.secret_name} --title #{name} --album #{name} --comment #{pwgen} --overWrite`
      else
        raise "What's a #{source_name}?"
      end
    end

    def pwgen
      `pwgen -N1`.chomp
    end
  end
end

def run!
  fixer = Fixer.new(File.expand_path("~/Downloads/mixtape/"))
  fixer.run!
end
run!
