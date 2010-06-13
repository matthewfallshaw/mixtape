class Tape < ActiveRecord::Base
  has_many :tracks
  has_many :tapesters
end
