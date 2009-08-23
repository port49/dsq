require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Item" do

  it "should receive a time on initialization" do
    i = Item.new( 37 )
    i.created_at.should == 37
  end

  it "should have semantic functions to record times it enters/leaves queue and enters/leaves service" do
    i = Item.new( 37 )
    i.enter_queue( 42 )
    i.leave_queue( 52 )
    i.enter_service( 56 )
    i.leave_service( 72 )

    i.created_at.should == 37
    i.entered_queue_at.should == 42
    i.left_queue_at.should == 52
    i.entered_service_at.should == 56
    i.left_service_at.should == 72
  end

  it "should have bang! forms of the semantic functions to record times it enters/leaves queue and enters/leaves service" do
    i = Item.new( 37 )
    Event.time = 42
    i.enter_queue!
    Event.time = 52
    i.leave_queue!
    Event.time = 56
    i.enter_service!
    Event.time = 72
    i.leave_service!

    i.created_at.should == 37
    i.entered_queue_at.should == 42
    i.left_queue_at.should == 52
    i.entered_service_at.should == 56
    i.left_service_at.should == 72
  end

end
