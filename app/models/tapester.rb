class Tapester < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :rememberable,
    :trackable, :validatable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :posts_attributes

  has_many :tracks, :dependent => :destroy do
    def populate
      Tape.all.each do |tape|
        unless proxy_owner.committed_tape_ids.include?(tape.id)
          proxy_target << Track.new(:tapester => proxy_owner, :tape => tape)
        end
      end
      proxy_target

      ### Annoying! This code works in the specs, and when there's a debugger
      ### call in the middle, but not otherwise!
      # Tape.all.each do |tape|
      #   unless proxy_target.collect {|track| track.tape.id }.include?(tape.id)
      #     proxy_target << Track.new(:tapester => proxy_owner, :tape => tape)
      #   end
      # end
    end
  end
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

  def orphan?
    encrypted_password.blank? && reset_password_token.blank?
  end

  def committed_tape_ids
    tracks.collect {|track| track.tape.id }
  end
  def uncommitted_tape_ids
    Tape.all.collect {|tape| tape.id } - committed_tape_ids
  end

  def <=>(other)
    self.name <=> other.name
  end
  
end
