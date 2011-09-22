test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestQueue < MiniTest::Unit::TestCase
  def test_receives_population_assignment
    q = Queue.new do
      given_population
    end
    assert q.population.is_a? Population
  end

  def test_receives_arrival_rate_and_automatically_makes_population_assignment
    q = Queue.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    assert q.population.arrival_rate.is_a? ExponentialRandomVariate
  end

  def test_receives_server_assignment
    q = Queue.new do
      given_server
    end
    assert q.server.is_a? Server
  end
end
