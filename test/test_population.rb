test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestPopulation < MiniTest::Unit::TestCase
  def test_arrival_rate_assignment
    population = Population.new do
      with_arrival_rate :exponential, :mean => 1.0
    end
    assert population.arrival_rate.is_a?(ExponentialRandomVariate)
  end

  def test_prevent_arrival_while_waiting
    population = Population.new
    population.instance_variable_set('@waiting', true)
    assert_raises(DSQ::PopulationError) do
      population.arrive!
    end
  end
end
