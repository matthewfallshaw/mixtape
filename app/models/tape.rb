class Tape < ActiveRecord::Base
  has_many :tracks, :dependent => :destroy
  has_many :tapesters, :through => :tracks

  validates :name, :uniqueness => true

  def track_for(tapester)
    tracks.where(:tapester_id => tapester.id).all.only
  end

  def uncommitted_tapesters
    (Tapester.all - tapesters).sort
  end

  def <=>(other)
    self.name <=> other.name
  end

end
