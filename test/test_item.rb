test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestItem < MiniTest::Unit::TestCase
  def test_time_on_initialization
    item = Item.new 37
    assert_equal 37, item.created_at, "Item has the wrong time."
  end

  def test_semantic_functions_for_timing
    item = Item.new    37
    item.enter_queue   42
    item.leave_queue   52
    item.enter_service 56
    item.leave_service 72
    assert_equal 37, item.created_at
    assert_equal 42, item.entered_queue_at
    assert_equal 52, item.left_queue_at
    assert_equal 56, item.entered_service_at
    assert_equal 72, item.left_service_at
  end

  def test_semantic_functions_for_timing_based_on_global_time
    Event.time = 37; item = Item.new
    Event.time = 42; item.enter_queue!
    Event.time = 52; item.leave_queue!
    Event.time = 56; item.enter_service!
    Event.time = 72; item.leave_service!
    assert_equal 37, item.created_at
    assert_equal 42, item.entered_queue_at
    assert_equal 52, item.left_queue_at
    assert_equal 56, item.entered_service_at
    assert_equal 72, item.left_service_at
  end
end
