require File.join( File.dirname(__FILE__), 'spec_helper' )

describe "Item" do

  it "should receive a time on initialization" do
    i = Item.new( 37 )
    i.created_time.should == 37
  end

  it "should record time enters queue" do
    i = Item.new( 37 )
    i.enter_queue( 42 )
    i.entered_queue_time.should == 42
  end

  it "should record time begins being served" do
    i = Item.new( 37 )
    i.start_being_served( 52 )
    i.started_being_served_time.should == 52
  end

  it "should record time ends being served" do
    i = Item.new( 37 )
    i.end_being_served( 67 )
    i.end_being_served_time.should == 67
  end

end
