Object.class_eval do
  def to_boolean
    return [true, "true", 1, "1"].include?(self.class == String ? self.downcase : self)
  end
end
