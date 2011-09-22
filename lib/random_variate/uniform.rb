class UniformRandomVariate < RandomVariate
  attr_accessor :start
  attr_accessor :end

  def initialize(options = {})
    raise(DSQ::RandomVariateError, "You must supply an end value if you specify a start values to a uniform variate generator.", caller) if(options[:start] && !options[:end])
    raise(DSQ::RandomVariateError, "You must supply a start value if you specify an end values to a uniform variate generator.", caller) if(!options[:start] && options[:end])
    super

    if @start && @end
      def generate!; return @start + ((@end - @start) * rand); end
    else
      def generate!; rand; end
    end
  end
end
