# An instance of a Simulation can have several Queues, which in tern tcan have several
# Populations and Services.
class Queue
  attr :populations
  attr :servers

  def initialize( options = {}, &block )
    # Set default values.
    @populations = []
    @servers = []
    
    prepopulate_attrs( options )

    instance_eval &block if block_given?
  end

  # Convenience method to create a population.
  def given_population( &block )
    @populations.push( Population.new( &block ) )
  end

  # Convenience method to create a single population with the given arrival rate.
  def with_arrival_rate( species, *args )
    self.given_population do
      with_arrival_rate( species, *args )
    end
  end

  # A Queue can have several Populations, but we refer to the first for convenience.
  def population
    @populations.first
  end

  # Convenience method to create a server.
  def given_server( &block )
    @servers.push( Server.new( &block ) )
  end

  # Convenience method to create a single server with the given service rate.
  def with_service_rate( species, *args )
    self.given_server do
      with_service_rate( species, *args )
    end
  end

  # A Queue can have several Servers, but we refer to the first for convenience.
  def server
    @servers.first
  end

end
