class NormalRandomVariate < RandomVariate
  attr_accessor :mean
  attr_accessor :standard_deviation

  def initialize(options = {})
    raise(DSQ::RandomVariateError, "You must supply a mean value to a normal variate generator.", caller) if(!options[:mean])
    raise(DSQ::RandomVariateError, "You must supply a standard deviation value to a normal variate generator.", caller) if(!options[:standard_deviation])
    super
  end

  def generate!
    rand_a = rand
    rand_b = rand
    if rand > 0.5
      Math.sqrt(-2 * Math.log(rand_a)) * Math.cos(2 * Math::PI * rand_b)
    else
      Math.sqrt(-2 * Math.log(rand_a)) * Math.sin(2 * Math::PI * rand_b)
    end
  end
end
