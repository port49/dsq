# Instances of the Server class are often used to respond to items in Queues.
class Server
  attr_accessor :service_rate

  def initialize(options = {}, &block)
    # Set default values.
    prepopulate_attrs(options)

    instance_eval &block if block_given?
  end

  # Set a random variate as the arrival rate.
  def with_service_rate(species, *args)
    @service_rate = RandomVariate.send(species, *args)
  end

end

