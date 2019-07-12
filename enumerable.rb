module Enumerable
    def my_each
        i = 0
        while i < self.size do
            yield(self[i])
            i+=1
        end
    end

    def my_each_with_index
        i = 0
        while i < self.size do
            yield(self[i], i)
            i+=1
        end
    end

    def my_select
        res = []
        self.my_each do |v|
          if yield v
            res << v
          end
        end
        res
    end

    def my_all?
        self.my_each {|v| return false unless yield v} 
        true
    end

    def my_any?
        self.my_each {|v| return true if yield v}
        false
    end

    def my_none?
        self.my_each {|v| return false unless yield v}
        true
    end

    def my_count
        res = 0
        self.my_each {|v|  res+=1 if yield v}
        res
    end

    def my_map(proc = nil)
        res = []
        self.my_each {|v|  res << yield(v) } if proc == nil
        self.my_each {|v|  res << proc.call(v) } if proc
        res
    end

    def my_inject(intial = 0)
        res = intial
        self.my_each {|v|  res = yield(res, v) }
        res
    end
end

# test function for inject
def multiply_els(arr)
    p arr.my_inject(1) {|product, v| product * v}
end

#input
arr = [1,2,3,4,5,6]

#each
arr.each {|v| p v}
arr.my_each {|v| p v}

#each_witn_index
arr.each_with_index {|v,i| p "#{i} => #{v}"}
arr.my_each_with_index {|v,i| p "#{i} => #{v}"}

#select
arr.select {|x| p x}
arr.my_select {|x| p x}

#all?
p arr.all? {|v| v >= 1} 
p arr.my_all? {|v| v >= 1}

#any?
p arr.any? {|v| v >= 2} 
p arr.my_any? {|v| v >= 2}

#my_none?
p arr.none? {|v| v >= 2}
p arr.my_none? {|v| v >= 2}

#my_count
p arr.count {|v| v >= 2}
p arr.my_count {|v| v >= 2}

#my_map
new_arr = arr.map {|x| x**2}
my_new_arr = arr.my_map {|x| x**2}

my_proc = Proc.new {|x| x**2}
my_new_arr_with_proc = arr.my_map(my_proc)

p new_arr, my_new_arr, my_new_arr_with_proc


#my_inject
p arr.inject {|sum, v| sum + v}
p arr.my_inject {|sum, v| sum + v}
multiply_els([2,4,5])


