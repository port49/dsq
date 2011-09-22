test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'..','helper'))

class TestNormal < MiniTest::Unit::TestCase
  def test_raise_error_if_mean_is_missing
    assert_raises(DSQ::RandomVariateError) do
      RandomVariate.normal(:standard_deviation => 1.0)
    end
  end

  def test_raise_error_if_standard_deviation_is_missing
    assert_raises(DSQ::RandomVariateError) do
      RandomVariate.normal(:mean => 0.1)
    end
  end

  def test_pass_chi_square_for_uniform_distribution
    mean = 1.0
    standard_deviation = 1.0

    normal = RandomVariate.normal(:mean => mean, :standard_deviation => standard_deviation)
    test_data = []
    100.times do
      test_data << normal.generate!
    end
    segments = (0..10).to_a.collect{|n| (0.5 * (1 + Math.erf(((n.to_f / 10) - mean) / (standard_deviation * Math.sqrt(2)))))}
    # segments looks like [ 0.158655253931457, 0.18406012534676, ... 0.5 ]
    assert RandomVariate.chi_square_statistic(test_data, segments) < 16.919
  end
end
