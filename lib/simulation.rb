# We generally only deal with one instance of a Simulation at a time.
class Simulation
  attr_reader :queues

  def initialize( options = {}, &block )
    # Set default values.
    @queues = []
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end
    
#raise "#{ block.to_s } \n-----------"  
#    eval block.to_s, block.binding
    instance_eval &block if block_given?
  end
  
  def given_queue( &block )
    @queues.push( Queue.new( &block ) )
  end

  # A Simulation can have several Queues, but we refer to the first for convenience.
  def queue
    @queues.first
  end
  
end
