test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestArray < MiniTest::Unit::TestCase
  def setup
    @test_array = (1..100).to_a
  end

  def test_sum_of_elements
    assert_equal @test_array.sum, 5050, "Can't sum an array."
  end

  def test_shaving_unwanted_array_elements
    assert_equal @test_array.length, 100, "Array starts off with unexpected length."
    assert_equal @test_array.shave!{|n| n<=10}, 10, "Shave returns wrong number of removed elements."
    assert_equal @test_array.length, 90, "Shaved array is incorrect size."
  end
end

