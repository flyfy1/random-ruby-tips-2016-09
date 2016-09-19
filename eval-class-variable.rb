# Problem 1: shared class variable for inheritance
=begin
class P1
  @@counter = 1

  def initialize
    @@counter += 1
  end

  def counter
    @@counter
  end
end

class A1 < P1
end

class B1 < P1
end

puts A1.new.counter
puts B1.new.counter
puts A1.new.counter
puts B1.new.counter
=end

module M
  def self.included(clz)
    clz.class_eval do
      def self.count_inc
        hash[:count] += 1
      end

      def self.count
        hash[:count]
      end

      private
      def self.hash
        class_variable_set(:@@h, Hash.new(0)) unless class_variable_defined? :@@h
        class_variable_get :@@h
      end
    end
  end
end

class A
  include M

  count_inc
  count_inc
  count_inc

  puts "count from A: #{count}"
end
p A.singleton_class.ancestors

class B
  puts "count from B defined: #{class_variable_defined? :@@count}"

  include M

  count_inc
  count_inc

  puts "count from B: #{count}"
end
p B.singleton_class.ancestors

=begin
# Problem 2: mysterious module include
module M
  def count_inc
    hash[:count] += 1
  end

  def count
    hash[:count]
  end

  private
  def hash
    class_variable_set(:@@h, Hash.new(0)) unless class_variable_defined? :@@h
    class_variable_get :@@h
  end
end

class A
  extend M

  count_inc
  count_inc
  count_inc

  puts "count from A: #{count}"
end
p A.singleton_class.ancestors

class B
  puts "count from B defined: #{class_variable_defined? :@@count}"

  extend M

  count_inc
  count_inc

  puts "count from B: #{count}"
end
p B.singleton_class.ancestors

=begin
# Solution: set upon the 
class P2
  def initialize
    clz = self.class
    clz.instance_variable_set(:@counter, 0) unless clz.instance_variable_defined? :@counter
    count = clz.instance_variable_get :@counter 
    clz.instance_variable_set(:@counter, count + 1)
  end

  def counter
    self.class.instance_variable_get(:@counter)
  end
end

class A2 < P2
end

class B2 < P2
end

puts A2.new.counter
puts B2.new.counter
puts A2.new.counter
puts B2.new.counter
=end
