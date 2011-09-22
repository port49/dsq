test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestSimulation < MiniTest::Unit::TestCase
  def test_receive_queue_assignment
    s = Simulation.new do
      given_queue
    end
    assert s.queue.is_a? Queue
  end

  def test_receive_arrival_rate_and_automatically_make_population
    s = Simulation.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    assert s.queue.population.arrival_rate.is_a? ExponentialRandomVariate
  end

  def test_receive_service_rate_and_automatically_make_server
    s = Simulation.new do
      with_service_rate :exponential, :mean => 1.0
    end
    assert s.queue.server.service_rate.is_a? ExponentialRandomVariate
  end

  def test_has_current_time
    s = Simulation.new
    assert s.current_time.to_i.is_a? Integer
  end
end
