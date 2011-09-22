test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestRandomVariate < MiniTest::Unit::TestCase
  def test_basic_factory_pattern_to_return_species_of_variate
    assert_equal :exponential, RandomVariate.exponential(:mean => 3.12).species
    assert_equal :normal,      RandomVariate.normal(:mean => 3.12, :standard_deviation => 2.72).species
    assert_equal :uniform,     RandomVariate.uniform.species
    assert_equal :uniform,     RandomVariate.uniform(:integers => true).species
  end

  def test_contrived_chi_squared_coefficient_returns_expected_value
    # Simplest case of exact parity.
    test_data = (1..100).to_a  # [ 1, 2, 3, ... 99, 100 ]
    segments = (0..10).to_a.collect{|n| n * 10}  # [ 0, 10, 20, ... 90, 100 ]
    assert_equal 0, RandomVariate.chi_square_statistic(test_data, segments)

    # Extreme case of front-weighted data.
    test_data = Array.new(100, 1).to_a  # [ 1, 1, 1, ... 1, 1 ]
    segments = (0..10).to_a.collect{|n| n * 10}  # [ 0, 10, 20, ... 90, 100 ]
    assert_equal 900, RandomVariate.chi_square_statistic(test_data, segments)
  end

  def test_autofill_values
    RandomVariate.class_eval{attr_accessor(:dummy_value)}
    test_generator = RandomVariate.new(:dummy_value => 3.14)
    assert_equal 3.14, test_generator.dummy_value
  end
end
