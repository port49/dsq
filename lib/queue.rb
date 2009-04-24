# An instance of a Simulation can have several Queues, which in tern tcan have several
# Populations and Services.
class Queue
  attr :populations
  attr :servers

  def initialize( options = {}, &block )
    # Set default values.
    @populations = []
    @servers = []
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end

    instance_eval &block if block_given?
  end

  def given_population( &block )
    @populations.push( Population.new( &block ) )
  end

  # A Queue can have several Populations, but we refer to the first for convenience.
  def population
    @populations.first
  end

  def given_server( &block )
    @servers.push( Server.new( &block ) )
  end

  # A Queue can have several Servers, but we refer to the first for convenience.
  def server
    @servers.first
  end

end
