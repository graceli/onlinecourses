# metaprogramming to the rescue!
 
class Numeric
  @@currencies = {'dollar' => 1, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
    
  def in(currency)
    # super simple!! don't over think it!
    self / @@currencies[singular_currency(currency)] 
  end
  
  def singular_currency(currency)
      currency.to_s.gsub( /s$/, '')
  end
  
  def method_missing(method_id)
    currency = singular_currency(method_id)
    if @@currencies.has_key?(currency)
      self * @@currencies[currency]
    else
      super
    end
  end
end

class String
  def palindrome?
  	word_string = self.gsub(/\W/, '').downcase
    return word_string == word_string.reverse
  end
end

module Enumerable
  def palindrome?
    reversed = []
    self.reverse_each {|i| reversed.push(i)}
    self.to_a.eql?(reversed)
  end
end

puts "part 1:"
puts 1.euro
puts 50.yen
# puts (1.euro - 50.yen).in(:rupees)  
puts 10.rupees.in(:euro)
# puts "part 2:"
# puts "foo".palindrome?
# puts [1,2,3,2,1].palindrome? 
h = {"hello"=>"world"}
p h, h.palindrome?
p [1,2,3,4,3,2,1], [1,2,3,4,3,2,1].palindrome?
p [1,2,3,4,3,2], [1,2,3,4,3,2].palindrome?
p (1..2), (1..2).palindrome?
p ["a", "b", "c", "b", "a"], ["a", "b", "c", "b", "a"].palindrome?