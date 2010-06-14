class Tapester < ActiveRecord::Base
  has_many :tracks
  has_many :tapes, :through => :tracks, :uniq => true

  # I want to be able to say:
  #   tapester.tapes.each do |tape|
  #     if tape.track
  #       puts tape.track
  #     else
  #       puts "No track recorded"
  #     end
  #   end
  # ... where tapester.tapes returns Tape.all

  validates :name, :uniqueness => true
end
