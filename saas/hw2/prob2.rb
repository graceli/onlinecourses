class CartesianProduct
  include Enumerable
  # your code here
  def initialize(a, b)
    @a = a
    @b = b
  end
  
  def each
    @a.each do |i|
      @b.each do |j|
        yield [i,j]
      end
    end
  end
end

c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

c = CartesianProduct.new([4,5], [:a,:b])
c.each { |elt| puts elt.inspect }
