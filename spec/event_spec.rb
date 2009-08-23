require File.join( File.dirname(__FILE__), 'spec_helper' )

describe Event do

  before( :each ) do

    Event.time = 0
    Event.instance.list = []
    Event.plan!( 31, lambda{ return "event 2" } )
    Event.plan!( 7, lambda{ return "event 1" } )
    Event.plan!( 451, lambda{ return "event 3" } )

  end
  

  it "should follow a singleton design pattern, and not allow multiple instances" do
    lambda{ Event.new }.should raise_error( NoMethodError )
  end

  it "should take planned events and add them to the list" do
   Event.list.length.should == 3
  end

  it "should take sort the list of planned events" do
    Event.sort!
    Event.list.collect{ |event| event[0] }.should == [ 7, 31, 451 ]
  end

  it "should take planned events and sort them and execute the first one" do
    work = "incomplete"
    Event.plan!( 5, lambda{ work = "complete" } )
    Event.proceed!
    work.should == "complete"
  end

  it "should raise an error if the planned time is earlier than the current time" do
    Event.time = 32
    lambda{ Event.plan!( 31, lambda{ return "event 2" } ) }.should raise_error( DSQ::EventSchedulingError, "We don't allow time-travel in DSQ, and you tried to schedule an event before the current time." )
  end

end

