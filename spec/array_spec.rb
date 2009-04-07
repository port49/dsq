require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Array" do

  it "should sum it's elements" do
    ( 1..100 ).to_a.sum.should ==( 5050 )
  end

  it "should remove unwanted elements and return the number of removed" do
    test_array = ( 1..100 ).to_a
    test_array.length.should ==( 100 )
    test_array.shave!{ |n| n <= 10 }.should ==( 10 )
    test_array.length.should ==( 90 )
    test_array.shave!{ |n| n.is_a?( Integer ) }.should ==( 90 )
    test_array.length.should ==( 0 )
  end
end

