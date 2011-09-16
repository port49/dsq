# The singleton design pattern is included in the standard Ruby library.
require 'singleton'

class Event
  attr_accessor :time
  attr_accessor :list
  
  # This will give us access to a single instance object.
  include Singleton
  
  def initialize
    # Set default values.
    @time = 0
    @list = []
  end
  
  # Pass the time method to the singleton instance.
  def self.time
    return self.instance.time
  end
  
  # Pass the time setter method to the singleton instance.
  def self.time=( time )
    self.instance.time = time
  end
  
  # Pass the list method to the singleton instance.  This list holds all future
  # potential events.
  def self.list
    self.instance.list
  end
  
  # Sort the list of events based on scheduled time.
  #
  # @param
  # @return self
  def self.sort!
    self.list.sort!{ |a, b| a[0] <=> b[0] }
    return self
  end

  # Call the event at the front of the event queue.
  #
  # @param
  # @return self
  def self.call_first_event!
    if( event_to_execute = self.list.shift )
      event_to_execute[1].call
    end
    return self
  end

  # Sort the events, and run the next event.
  #
  # @param
  # @return self
  def self.proceed!
    self.sort!.call_first_event!
  end
  
  # The plan method requires a future time expressed numerically and an lambda
  # which will be called if and when the simulation makes it to that time.
  def self.plan!( time, action )
    raise( DSQ::EventSchedulingError, "We don't allow time-travel in DSQ, and you tried to schedule an event before the current time.", caller ) if( time < self.time )
    raise( DSQ::EventSchedulingError, "First argument must be numeric.  We expect an Integer, but Float is also acceptable.", caller ) unless( [ Integer, Float, Fixnum ].include? time.class )
    raise( DSQ::EventSchedulingError, "Second argument must be a lambda or some other object responding to 'call'.", caller ) unless( action.respond_to?( :call ) )

    self.list << [ time, action ]
  end
  
  # This method performs the actual work.  First the stack is sorted by scheduled
  # time.  Then the first event is popped off the time is set to that scheduled
  # time and the associated lambda is called.
  #
  # @params
  # @return [Boolean] true if the event was run
  def self.proceed()
  end
end
