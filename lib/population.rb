# Instances of the Population class are often used to feed items into Queues.
class Population

  def initialize( options = {}, &block )
    # Set default values.
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end
  end

end
=begin
  attr_accessor :context
  attr_accessor :busy
  attr_accessor :intervals
  attr_accessor :generator
  attr_accessor :finished_count
  
  def initialize( calling_class )
    @context = calling_class
    @busy = false
    @intervals = []
    @generator= RandomVariate.select( :uniform )
    @finished_count = 0
    
    yield( self ) if block_given?
  end

  def work!( *stuff )
    raise "Error: service is currently busy!" if is_busy?
    @busy = true
  end
  
  def rest!
    raise "Error: service is not busy!" unless is_busy?
    @finished_count = @finished_count + 1
    @busy = false
  end

  def random_interval
    r = @generator.generate
    @intervals << r
    r
  end

  def is_busy?
    @busy == true
  end


  attr_accessor :group_size
  attr_accessor :continuous
  
  def initialize( calling_class )
    super
    @group_size = 1
    @continuous = false
    
    yield( self ) if block_given?
  end

  def work!
    super
    "Preparing a new arrival.\n" if context.is_verbose?
    group = []
    @group_size.times do
      group << QueueItem.new( context.current_time )
    end
    context.discipline.capture!( group )
    context.plan!( [ ( context.current_time + random_interval ), Proc.new{ self.rest! } ] )
  end
  
  def work_continuously!
    @continuous = true
    work!
  end
  
  def rest!
    super
    "New arrival sent.\n" if context.is_verbose?
    work! if @continuous
  end

end
=end
