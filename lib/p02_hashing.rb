class Fixnum
  # Fixnum#hash already implemented for you
end

def is_prime?(n)
  (2..Math.sqrt(n)).to_a.none? { |num| n % num == 0 }
end

def n_primes(n)
  primes = []
  i = 2
  until primes.size == n
    primes << i if is_prime?(i)
    i += 1
  end
  primes
end

class Array
  def hash
    return 1 if self.flatten == []
    primes = n_primes(self.length)
    self.flatten.map.with_index { |el, i| el * primes[i] }.reduce(:+)
  end
end

class String

  def hash
    return 1 if self == ""
    # primes = n_primes(self.length)
    # self.split("").map.with_index { |l,i| l.ord * primes[i] }.reduce(:+)
    self.split("").map { |l| l.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.values.sort.reduce(0) { |acc, el| acc + el.hash }
  end
end
