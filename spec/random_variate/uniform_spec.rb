require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe "UniformRandomVariate" do

  it "should raise error if both 'start' and 'end' value isn't supplied" do
    lambda{ RandomVariate.uniform( :start => 3.14 ) }.should raise_error( DSQ::RandomVariateError, "You must supply an end value if you specify a start values to a uniform variate generator." )
    lambda{ RandomVariate.uniform( :end => 3.14 ) }.should raise_error( DSQ::RandomVariateError, "You must supply a start value if you specify an end values to a uniform variate generator." )
  end

  it "should pass the chi-square test for uniform distribution" do
    @start = 1.0
    @end = 1.0

    uniform = RandomVariate.uniform
    test_data = []
    100.times do
      test_data << uniform.generate!
    end
    segments = ( 0..10 ).to_a.collect{ |n| ( n.to_f / 10 ) } 
    # segments looks like [ 0.0, 0.1, 0.2 ... 1.0 ]
    RandomVariate.chi_square_statistic( test_data, segments ).should <( 16.919 )
  end

end


