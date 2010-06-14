class Track < ActiveRecord::Base
  belongs_to :tapester
  belongs_to :tape

  validates :tapester, :presence => true
  validates :tape,     :presence => true
  validates :name,     :presence => true
  validates :url,      :presence => true,
    :format => { :with => %r{^(?:http://)?www.youtube.com/watch\?v=\w+$}, :if => Proc.new {|t| t.url } }
  validates_uniqueness_of :tape_id, :scope => :tapester_id
end
