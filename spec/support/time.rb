class Time
  def ==(other)
    to_i == other.to_i &&
      usec - (usec % 1000) == other.usec - (other.usec % 1000)
  end
end
