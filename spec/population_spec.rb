require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Population" do

  it "should receive an arrival rate assignment" do
    p = Population.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    
    p.arrival_rate.should be_a ExponentialRandomVariate
  end

  it "should raise an error if someone tries to produce an arrival while we are waiting" do
    p = Population.new
    p.waiting = true
    lambda{ p.arrive! }.should raise_error( DSQ::PopulationError, "You can not produce an arrival while the Population is waiting." )
  end

end
