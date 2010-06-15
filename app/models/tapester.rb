class Tapester < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  has_many :tracks, :dependent => :destroy
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
