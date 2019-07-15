# implementation of enumerable
module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    res = []
    my_each do |v|
      res << v if yield v
    end
    res
  end

  def my_all?
    my_each { |v| return false unless yield v }
    true
  end

  def my_any?
    my_each { |v| return true if yield v }
    false
  end

  def my_none?
    my_each { |v| return false if yield v }
    true
  end


  def my_count(arg = nil)
    res = 0
    my_each { |v| res += 1 if yield v } if block_given? && arg.nil?
    my_each { |v| res += 1 if arg == v } if !block_given? && !arg.nil?
    my_each { |v| res += 1 } if !block_given? && arg.nil?
    res
  end

  def my_map(proc = nil)
    res = []
    my_each { |v|  res << yield(v) } if proc.nil?
    my_each { |v|  res << proc.call(v) } if proc
    res
  end

  def my_inject(intial = 0)
    res = intial
    my_each { |v| res = yield(res, v) }
    res
  end
end

# test function for inject
def multiply_els(arr)
  p arr.my_inject(1) { |product, v| product * v }
end

=begin
# input
arr = [1, 2, 3, 4, 5, 6]

# each
arr.each { |v| p v }
arr.my_each { |v| p v }

# each_witn_index
arr.each_with_index { |v, i| p "#{i} => #{v}" }
arr.my_each_with_index { |v, i| p "#{i} => #{v}" }

# select
arr.select { |x| p x }
arr.my_select { |x| p x }

# all?
p arr.all? { |v| v >= 1 }
p arr.my_all? { |v| v >= 1 }

# any?
p arr.any? { |v| v >= 2 }
p arr.my_any? { |v| v >= 2 }

# my_none?
p arr.none? { |v| v == 2 }
p arr.my_none? { |v| v == 2 }

p arr.none? { |v| v == 7 }
p arr.my_none? { |v| v == 7 }

# my_count
# without arg
p arr.count 
p arr.my_count 

# with arg
p arr.count(1)
p arr.my_count(1) 

# with block
p arr.count { |v| v >= 2 }
p arr.my_count { |v| v >= 2 }


# my_map
new_arr = arr.map { |x| x**2 }
my_new_arr = arr.my_map { |x| x**2 }

my_proc = proc { |x| x**2 }
my_new_arr_with_proc = arr.my_map(my_proc)

p new_arr, my_new_arr, my_new_arr_with_proc

# my_inject
p arr.inject { |sum, v| sum + v }
p arr.my_inject { |sum, v| sum + v }
multiply_els([2, 4, 5])
=end