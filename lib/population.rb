# Instances of the Population class are often used to feed items into Queues.
class Population
  attr_accessor :arrival_rate

  def initialize(options = {}, &block)
    # Set default values.
    prepopulate_attrs(options)

    instance_eval &block if block_given?
  end

  # Set a random variate as the arrival rate.
  def with_arrival_rate(species, *args)
    @arrival_rate = RandomVariate.send(species, *args)
  end

  # Have an item arrive from the population.
  #
  # @param
  # @return [ Item ] the item that gets passed on to the caller, usually a queue
  def arrive!
    raise(DSQ::PopulationError, "You can not produce an arrival while the Population is waiting.", caller) if waiting?
    @waiting = true
    return Item.new
  end

  def rest!
    raise "Error: service is not busy!" unless is_busy?
    @finished_count = @finished_count + 1
    @busy = false
  end

private
  def waiting?
    @waiting
  end
end
