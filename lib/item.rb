# Items are typically created in populations, and go through queues.
class Item
  attr :time

  def initialize( time )
    # Set default values.
    @time = {}
    @time[:created] = time
  end
  
  def created_time
    @time[:created]
  end
  
  def enter_queue( time )
    @time[:enter_queue] = time
  end
  
  def start_being_served( time )
    @time[:start_being_served] = time
  end
  
  def end_being_served( time )
    @time[:end_being_served] = time
  end

end
