class Dog
  def initialize(name)
    @name   = name
    @hungry = true
  end

  def listen(masters_voice)
    if masters_voice == @name
      puts("WOOF! WOOF!")
    end
  end
end

dog = Dog.new("Fido")
dog.listen("Fido")
