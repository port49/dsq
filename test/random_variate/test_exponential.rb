test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'..','helper'))

class TestExponential < MiniTest::Unit::TestCase
  def test_raise_error_if_mean_is_missing
    assert_raises(DSQ::RandomVariateError) do
      RandomVariate.exponential
    end
  end

  def test_pass_chi_square_for_uniform_distribution
    # Simple case of mean = 1
    exponential = RandomVariate.exponential(:mean => 1.0)
    test_data = []
    100.times do
      test_data << exponential.generate!
    end
    segments = (0..9).to_a.collect{|n| (-1 * Math.log(1 - (n.to_f / 10)))} + [1.0 / 0]
    # segments looks like [ 0, 0.105360515657826, 0.22314355131421, ... 2.30258509299405, Infinity ]
    assert RandomVariate.chi_square_statistic(test_data, segments) < 16.919
  end
end
