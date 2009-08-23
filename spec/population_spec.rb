require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Population" do

  it "should receive an arrival rate assignment" do
    p = Population.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    
    p.arrival_rate.should be_a ExponentialRandomVariate
  end

end
