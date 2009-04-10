require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Simulation" do

  it "should receive a Queue assignment" do
    s = Simulation.new do
      given_queue
    end
    
    s.queue.should be_a Queue
  end

end
