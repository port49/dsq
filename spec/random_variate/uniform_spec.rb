require File.dirname(__FILE__) + '/../spec_helper'

describe "UniformRandomVariate" do

  it "should raise error if both 'start' and 'end' value isn't supplied" do
    lambda{ RandomVariate.uniform( :start => 3.14 ) }.should raise_error( DSQ::RandomVariateError, "You must supply an end value if you specify a start values to a uniform variate generator." )
    lambda{ RandomVariate.uniform( :end => 3.14 ) }.should raise_error( DSQ::RandomVariateError, "You must supply a start value if you specify an end values to a uniform variate generator." )
  end

  it "should pass the chi-square test for uniform distribution" do
    @mean = 1.0
    @standard_deviation = 1.0

    normal = RandomVariate.normal( :mean => @mean, :standard_deviation => @standard_deviation )
    test_data = []
    100.times do
      test_data << normal.generate!
    end
    segments = ( 0..10 ).to_a.collect{ |n| ( 0.5 * ( 1 + Math.erf( ( ( n / 10 ) - @mean ) / ( @standard_deviation * Math.sqrt( 2 ) ) ) ) )  } 
    # segments looks like [ 0.158655253931457, 0.18406012534676, ... 0.5 ]
    RandomVariate.chi_square_statistic( test_data, segments ).should <( 16.919 )
  end

end


