test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'..','helper'))

class TestUniform < MiniTest::Unit::TestCase
  def test_raise_error_if_start_is_missing_but_end_is_supplied
    assert_raises(DSQ::RandomVariateError) do
      RandomVariate.uniform(:end => 3.14)
    end
  end

  def test_raise_error_if_end_is_missing_but_start_is_supplied
    assert_raises(DSQ::RandomVariateError) do
      RandomVariate.uniform(:start => 3.14)
    end
  end

  def test_pass_chi_square_for_uniform_distribution
    uniform = RandomVariate.uniform
    test_data = []
    100.times do
      test_data << uniform.generate!
    end
    segments = (0..10).to_a.collect{|n| (n.to_f / 10)}
    # segments looks like [ 0.0, 0.1, 0.2 ... 1.0 ]
    assert RandomVariate.chi_square_statistic(test_data, segments) < 16.919
  end
end
