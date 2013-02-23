# Sample file
# Convert this to HTML with the command:
#     bin/rb2html demo/dog.rb

def initialize(name) # I dropped classes :-)
  # Although I did add comments, so I can explain
  # why there's an initialize method here
  @name   = name
  @hungry = false
end

def listen(masters_voice)
  # I also added multiple arguments -
  # try multiple parameters in method definitions too!
  puts("WOOF! WOOF!", @hungry)
end

# You can call methods on instance variables as well
dog = Dog.new("Fido")
dog.listen("Fido")
