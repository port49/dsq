class ExponentialRandomVariate < RandomVariate
  attr_accessor :mean

  def initialize(options = {})
    raise(DSQ::RandomVariateError, "You must supply a mean value to an exponential variate generator.", caller) if(!options[:mean])
    super
  end

  def generate!
    -1 * @mean * Math.log(rand)
  end
end
