class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = []
    self.each_with_index do |val, idx|
      if val.is_a?(Array)
        sum << val.flatten.reduce(&:^)
      else
      sum << val + idx
    end
    end
    sum.reduce(&:^).hash
  end
end

class String
  def hash
    sum = []
    self.chars.each_with_index do |ch, idx|
      sum << ch.ord + idx
    end
    sum.reduce(&:^).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = []

    self.to_a.sort.each_with_index do |el, idx|
        res = el.first.to_s.ord * el.last.ord + idx
        sum << res
    end
    sum.reduce(&:^).hash
  end
end
