class String
  class << self
    def random(length)
      (1..length).map{ ('a'..'z').to_a[rand(26)] }.join
    end
  end
end
