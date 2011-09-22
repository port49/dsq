test_dir = File.dirname(__FILE__)
require File.expand_path(File.join(test_dir,'helper'))

class TestEvent < MiniTest::Unit::TestCase
  def setup
    Event.reset!
    Event.time = 0
    Event.plan! 31, lambda{return "event 2"}
    Event.plan! 7,  lambda{return "event 1"}
    Event.plan! 451,lambda{return "event 3"}
  end

  def test_singleton_identity_of_class
    assert_raises(NoMethodError) do
      Event.new
    end
  end

  def test_event_reset
    Event.reset!
    assert_equal 0, Event.list.length, "Unexpected number of planned events."
  end

  def test_planned_events_were_added
    assert_equal 3, Event.list.length, "Unexpected number of planned events."
  end

  def test_sorting_of_events
    Event.sort!
    assert_equal [7,31,451], Event.list.map(&:first), "Events were not sorted."
  end

  def test_sorting_and_executing_next_event
    @work = "incomplete"
    Event.plan! 5, lambda{@work = "complete"}
    Event.proceed!
    assert_equal "complete", @work, "Event was not processed."
  end

  def test_event_comes_off_stack_after_completion
    assert_equal 3, Event.list.length, "Unexpected number of planned events."
    Event.plan! 5, lambda{@work = "complete"}
    assert_equal 4, Event.list.length, "Unexpected number of planned events."
    Event.proceed!
    assert_equal 3, Event.list.length, "Unexpected number of planned events."
  end

  def test_time_travel_disallowed
    Event.time = 32
    assert_raises(DSQ::EventSchedulingError) do
      Event.plan!(31, lambda{"flux capacitor"})
    end
  end
end
