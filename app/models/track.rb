class Track < ActiveRecord::Base
  belongs_to :tapester
  belongs_to :tape

  validates :tapester, :presence => true
  validates :tape,     :presence => true
  validates :name,     :presence => true
  validates :url,      :presence => true,
    :format => { :with => %r{^(?:http://)?www.youtube.com/watch\?v=[^&]+}, :if => Proc.new {|t| t.url } }
  validates :tape_id,  :uniqueness => { :scope => :tapester_id }
  validate :must_have_unique_base_url

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

  def base_url
    url.sub(/#.*$/,'') if url
  end

  def youtube_id
    url[/v=([^&]+)/,1]
  end

  private

  def must_have_unique_base_url
    other_track_base_urls = Track.all.select {|t| t.id != id }.collect(&:base_url)
    if other_track_base_urls.include?(base_url)
      errors.add :url, <<ERROR
: OMG! - You're not going to believe what just happened!
Someone else has already chosen that very exact same track!
You should choose another, and next time… perhaps you might try to get in a little earlier, eh?"
ERROR
    end
  end

end
