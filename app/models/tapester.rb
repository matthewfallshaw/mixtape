class Tapester < ActiveRecord::Base
  has_many :tracks
  has_many :tapes, :through => :tracks, :uniq => true

end
