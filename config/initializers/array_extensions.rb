class Array
  def only
    raise "called Array#only with array of length #{self.length}" if self.length>1
    self.first
  end
end
