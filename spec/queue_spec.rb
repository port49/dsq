require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Queue" do

  it "should receive a population assignment" do
    q = Queue.new do
      given_population
    end
    
    q.population.should be_a Population
  end

  it "should receive a server assignment" do
    q = Queue.new do
      given_server
    end
    
    q.server.should be_a Server
  end

end
