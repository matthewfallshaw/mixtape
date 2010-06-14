require 'digest/sha1'

class Tapester < ActiveRecord::Base

  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_password_field = false
    c.require_password_confirmation = false
  end

  attr_protected :id, :password_salt

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
  validates :password, :confirmation => true

  attr_accessor :password, :password_confirmation

  class << self

    def authenticate(email, pass)
      u = where(:email => email).first
      return nil if u.nil?
      return u if encrypt(pass, u.password_salt) == u.hashed_password
      nil
    end

    def encrypt(pass, salt)
      Digest::SHA1.hexdigest(pass + salt)
    end

  end

  def password=(pass)
    @password = pass
    self.password_salt = String.random(20) unless self.password_salt?
    self.hashed_password = self.class.encrypt(@password, self.password_salt)
  end

end
