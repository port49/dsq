# We generally only deal with one instance of a Simulation at a time.
class Simulation
  attr_reader :queues

  def initialize( options = {}, &block )
    # Set default values.
    @queues = []
    
    prepopulate_attrs( options )
    
    instance_eval &block if block_given?
  end
  
  # Convenience method to create a queue.
  def given_queue( &block )
    @queues.push( Queue.new( &block ) )
  end

  # Convenience method to create a single population with the given arrival rate.
  def with_arrival_rate( species, *args )
    self.given_queue do
      with_arrival_rate( species, *args )
    end
  end
 
  # Convenience method to create a single server with the given service rate.
  def with_service_rate( species, *args )
    self.given_queue do
      with_service_rate( species, *args )
    end
  end
 
  # A Simulation can have several Queues, but we refer to the first for convenience.
  def queue
    @queues.first
  end
  
  def current_time
    Event.time
  end
  
  def proceed!
    Event.proceed!
  end
end
