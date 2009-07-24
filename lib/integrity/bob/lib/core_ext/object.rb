class Object #:nodoc:
  # Add Object#tap for backwards compatibility
  def tap
    yield self
    self
  end unless method_defined?(:tap)
end
