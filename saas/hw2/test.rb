class C
end

class B < C
end

class A < B
end

a = A.new
b = B.new

p a.superclass == b.class
p A.superclass == B
p a.class.ancestors.include?(C)
p b.respond_to?('class')
