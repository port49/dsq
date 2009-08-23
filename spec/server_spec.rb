require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Server" do

  it "should receive a service rate assignment" do
    s = Server.new do
      with_service_rate :exponential, :mean => 1.0
    end
    
    s.service_rate.should be_a ExponentialRandomVariate
  end

end
