require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "RandomVariate" do

  it "should implement a very basic Factory Pattern to return a particular type of variate" do
    RandomVariate.exponential( :mean => 3.12 ).species.should ==( :exponential )
    RandomVariate.normal.species.should ==( :normal )
    RandomVariate.uniform.species.should ==( :uniform )
    RandomVariate.uniform( :integers => true ).species.should ==( :uniform )
  end
  
  it "should take contrived data for the chi_squared_coefficient and return the expected value" do
    RandomVariate.chi_squared_coefficient( ( 1..100 ).to_a, ( 0..10 ).to_a ).should ==( 0 )
  end
end

