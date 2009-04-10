# An instance of a Simulation can have several Queues, which in tern tcan have several
# Populations and Services.
class Queue

  def initialize( options = {}, &block )
    # Set default values.
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end

    instance_eval &block if block_given?
  end

end
