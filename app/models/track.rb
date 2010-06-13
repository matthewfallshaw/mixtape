class Track < ActiveRecord::Base
  has_one :tapester
  has_one :tape
end
