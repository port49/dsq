test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'..','helper'))

class TestSimplestQueue < MiniTest::Unit::TestCase
  def setup
    @simulation = Simulation.new do
      with_arrival_rate :exponential, :mean => 1.0
      with_service_rate :exponential, :mean => 0.9
    end
  end

  def test_running_simulation_for_1000_arrivals
    @simulation.proceed! until @simulation.arrivals.length == 1000
    assert_equal 1000, @simulation.arrivals.length, "Only ran for #{@simulation.arrivals.length} arrivals."
  end

  def test_running_simulation_for_1000_items_processed
    @simulation.proceed! until @simulation.items.length == 1000
    assert_equal 1000, @simulation.items.length, "Only ran for #{@simulation.items.length} items."
  end

  def test_running_simulation_until_time_1000
#    @simulation.proceed! until @simulation.current_time >= 1000
    assert @simulation.current_time >= 1000, "Only ran until #{@simulation.current_time}."
  end
end
