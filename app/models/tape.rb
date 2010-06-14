class Tape < ActiveRecord::Base
  has_many :tracks
  has_many :tapesters

  def track_for(tapester)
    tracks.where(:tapester_id => tapester.id).all.only
  end

end
