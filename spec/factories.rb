
Factory.define :tapester do |tapester|
  tapester.sequence(:name) {|n| "tapester_#{n}" }
end

Factory.define :tape do |tape|
  tape.sequence(:name) do |n|
    case n
    when 1
      "I am my own installation piece"
    when 2
      "I think, therefore I am.  I karaoke, therefore we all are too."
    when 3
      "To London, to London, to visit with Queen"
    when 4
      "The hair, the outfit, the shame"
    when 5
      "The revolution will not be televised"
    else
      String.random(8)
    end
  end
  tape.description { String.random(16) << "." }
end

Factory.define :track do |track|
  track.name { String.random(8) }
  track.url { "http://www.youtube.com/watch?v=#{ String.random(8) }" }
  track.association :tapester
  track.association :tape
end
