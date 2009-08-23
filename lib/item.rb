# Items are typically created in populations, and go through queues.
class Item
  attr_accessor :created_at
  attr_accessor :entered_queue_at
  attr_accessor :left_queue_at
  attr_accessor :entered_service_at
  attr_accessor :left_service_at

  # When we initialize an Item, we set it's context, from which we can
  # determine it's creation time.
  def initialize( time )
    # Set default values.
    @created_at = time
  end
  
  # Semantic function to set the time an Item enters the queue.
  def enter_queue( time )
    self.entered_queue_at = time
  end

  # Semantic function to set the time an Item leaves the queue. This 
  # value will often go unused, because the beginning of service often
  # corresponds to leaving the queue.
  def leave_queue( time )
    self.left_queue_at = time
  end
  
  # Semantic function to set the time an Item enters service.
  def enter_service( time )
    self.entered_service_at = time
  end

  # Semantic function to set the time an Item finishes service.
  def leave_service( time )
    self.left_service_at = time
  end
  
  # Bang! function to set the time an Item enters the queue based on current Event time.
  def enter_queue!
    self.enter_queue( Event.time )
  end

  # Bang! function to set the time an Item leaves the queue based on current Event time.
  # This value will often go unused, because the beginning of service often
  # corresponds to leaving the queue.
  def leave_queue!
    self.leave_queue( Event.time )
  end
  
  # Bang! function to set the time an Item enters service based on current Event time.
  def enter_service!
    self.enter_service( Event.time )
  end

  # Bang! function to set the time an Item leaves service based on current Event time.
  def leave_service!
    self.leave_service( Event.time )
  end
  
end
