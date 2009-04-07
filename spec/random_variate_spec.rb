require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "RandomVariate" do

  it "should implement a very basic Factory Pattern to return a particular type of variate" do
    RandomVariate.exponential( :mean => 3.12 ).species.should ==( :exponential )
    RandomVariate.normal.species.should ==( :normal )
    RandomVariate.uniform.species.should ==( :uniform )
    RandomVariate.uniform( :integers => true ).species.should ==( :uniform )
  end
  
  it "should take contrived data for the chi_squared_coefficient and return the expected value" do

    # Simplest case of exact parity.
    test_data = ( 1..100 ).to_a  # [ 1, 2, 3, ... 99, 100 ]
    segments = ( 0..10 ).to_a.collect{ |n| n * 10 }  # [ 0, 10, 20, ... 90, 100 ]
    RandomVariate.chi_square_statistic( test_data, segments ).should ==( 0 )

    # Extreme case of front-weighted data.
    test_data = Array.new( 100, 1 ).to_a  # [ 1, 1, 1, ... 1, 1 ]
    segments = ( 0..10 ).to_a.collect{ |n| n * 10 }  # [ 0, 10, 20, ... 90, 100 ]
    RandomVariate.chi_square_statistic( test_data, segments ).should ==( 900 )

  end

  it "should autofill values for which the class has an accessor" do
    RandomVariate.class_eval{ attr_accessor( :dummy_value ) }
    test_generator = RandomVariate.new( :dummy_value => 3.14 )
    test_generator.dummy_value.should ==( 3.14 )
  end
end

