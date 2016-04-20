class Friend
  attr_reader :name
  def intialize(name)
    @name = name
  end
  def greeting(name = nil)
    return "Hello!" if name == nil
    return "Hello, #{name}!"
  end
end
