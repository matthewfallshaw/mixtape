class Track < ActiveRecord::Base
  belongs_to :tapester
  belongs_to :tape

  validates :tapester, :presence => true
  validates :tape,     :presence => true
  validates :name,     :presence => true
  validates :url,      :presence => true,
    :format => { :with => %r{^(?:http://)?www.youtube.com/watch\?v=[^&]+}, :if => Proc.new {|t| t.url } }
  validates_uniqueness_of :tape_id, :scope => :tapester_id

  def url=(u)
    uri = URI.parse(u).normalize
    uri.scheme = "http"
    if uri.host.blank? || uri.host.match(/youtube.com/)
      uri.host = "www.youtube.com" 
    end
    uri.path = uri.path[%r{(/.*)},1]  # for some reason the host is getting prepended to the path
                                      # strip it off again
    uri.query = uri.query[%r{(v=[^&]+)}, 1] unless uri.query.blank?
    self[:url] = uri.to_s
  end
end
