class Track < ActiveRecord::Base
  belongs_to :tapester
  belongs_to :tape
end
