require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe "ExponentialRandomVariate" do

  it "should raise error if 'mean' value isn't supplied" do
    lambda{ RandomVariate.exponential }.should raise_error( DSQ::RandomVariateError, "You must supply a mean value to an exponential variate generator." )
  end

  it "should pass the chi-square test for uniform distribution" do
    # Simple case of mean = 1
    exponential = RandomVariate.exponential( :mean => 1.0 )
    test_data = []
    100.times do
      test_data << exponential.generate!
    end
    segments = ( 0..9 ).to_a.collect{ |n| ( -1 * Math.log( 1 - ( n.to_f / 10 ) ) ) } + [ 1.0 / 0 ] 
    # segments looks like [ 0, 0.105360515657826, 0.22314355131421, ... 2.30258509299405, Infinity ]
    RandomVariate.chi_square_statistic( test_data, segments ).should <( 16.919 )
  end

end


