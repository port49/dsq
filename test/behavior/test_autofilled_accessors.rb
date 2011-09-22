test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'..','helper'))

class TestAutofilledAccessorsBehavior
  attr_accessor :dummy_value
  def initialize(options = {}, &block)
    prepopulate_attrs(options)
  end
end

class TestAutofilledAccessors < MiniTest::Unit::TestCase
  def test_autofill_for_accessor
    test_class = TestAutofilledAccessorsBehavior.new(:dummy_value => 3.14)
    assert_equal 3.14, test_class.dummy_value
  end
end
