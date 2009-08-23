require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe "A simple queue" do

  before( :each ) do

    @s = Simulation.new do
      with_arrival_rate :exponential, :mean => 1.0
      with_service_rate :exponential, :mean => 0.9
    end

  end
  
  it "should run the simulation for 1000 arrivals" do
    @s.proceed! until @s.arrivals.length = 10000
    @s.arrivals.length.should ==( 10000 )
  end

  it "should run the simulation for 1000 items processed" do
    @s.proceed! until @s.items.length == 10000
    @s.items.length.should ==( 10000 )
  end

  it "should run the simulation for at least 10000 time units" do
    @s.proceed! until @s.current_time >= 10000
    @s.current_time.should >=( 10000 )
  end
end
