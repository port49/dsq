test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestServer < MiniTest::Unit::TestCase
  def test_receive_service_rate
    s = Server.new do
      with_service_rate :exponential, :mean => 1.0
    end
    assert s.service_rate.is_a? ExponentialRandomVariate
  end
end
