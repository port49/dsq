require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Simulation" do

  it "should receive a Queue assignment" do
    s = Simulation.new do
      given_queue
    end
    
    s.queue.should be_a Queue
  end

  it "should receive an arrivale rate and automatically make a population assignment" do
    s = Simulation.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    
    s.queue.population.arrival_rate.should be_a ExponentialRandomVariate
  end

  it "should receive a service rate and automatically make a server assignment" do
    s = Simulation.new do
      with_service_rate :exponential, :mean => 1.0
    end
    
    s.queue.server.service_rate.should be_a ExponentialRandomVariate
  end

   it "should pass 'proceed!' to the Event singleton" do
    s = Simulation.new do
      with_service_rate :exponential, :mean => 1.0
    end
    Event.should_receive( :proceed! ).and_return( Event.instance )
    s.proceed!
  end

  it "should know the current_time" do
    s = Simulation.new
    s.current_time.to_i.should be_a Integer
  end

end
