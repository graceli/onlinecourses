# Advanced OOP with some metaprogramming

# First extend Ruby's Class

class Class
  def attr_accessor_with_history(attr_name)
    # use .to_s to make sure that its a string
    attr_name = attr_name.to_s
    
    # create the attribute's getter
    attr_reader attr_name
    
    # bar history getter
    attr_reader attr_name + "_history"
      
    # Need to some how add an instance variable history which stores
    # a variable's value when the setter is called
    class_eval %Q{
      def #{attr_name}=(value)
        if @#{attr_name}_history.nil?
          @#{attr_name}_history = [nil, value]
        else
          @#{attr_name}_history.push(value)
        end
        @#{attr_name}=value
      end}
  end
end

class Foo
  attr_accessor_with_history :x
end

f = Foo.new
f.x = 1
f.x = 2
f.x = "hello!"
p f.x_history
f = Foo.new
f.x =4
p f.x_history
