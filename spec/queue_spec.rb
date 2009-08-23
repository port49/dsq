require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Queue" do

  it "should receive a population assignment" do
    q = Queue.new do
      given_population
    end
    
    q.population.should be_a Population
  end

  it "should receive an arrivale rate and automatically make a population assignment" do
    q = Queue.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    
    q.population.arrival_rate.should be_a ExponentialRandomVariate
  end

  it "should receive a server assignment" do
    q = Queue.new do
      given_server
    end
    
    q.server.should be_a Server
  end

end
