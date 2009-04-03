require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Array" do

  it "should sum it's elements" do
    ( 1..100 ).to_a.sum.should ==( 5050 )
  end

end

