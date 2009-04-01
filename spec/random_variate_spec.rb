require File.dirname(__FILE__) + '/spec_helper'

describe "RandomVariate" do

  it "should implement a very basic Factory Pattern to return a particular type of variate" do
    RandomVariate.exponential.species.should ==( :exponential )
    RandomVariate.normal.species.should ==( :normal )
    RandomVariate.uniform.species.should ==( :uniform )
    RandomVariate.uniform( :integers => true ).species.should ==( :uniform )
  end

end

