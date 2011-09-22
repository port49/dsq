# Ruby version 1.9.1 uses a modified Mersenne Twister with a period of 2**19937-1
class RandomVariate
  # If this is set, we store the generated values in an array, perhaps
  # to re-run a series using the same random variates.
  attr_accessor :store_values

  # Provide a class for errors.
  class Error < Exception; end

  # We use a Factory Pattern to return a particular species of RandomVariate.
  [:exponential, :normal, :uniform].each do|species|
    species_class = species.to_s.capitalize + "RandomVariate"

    # Define this species as a class method.  Note that Ruby1.9+ defines constants
    # as symbols, while earlier versions use strings.
    class_eval <<-METHOD_DEF
      def self.#{species}(*args)
        if(Object.constants.include?(:#{species_class}) || Object.constants.include?("#{species_class}"))
          return #{species_class}.new(*args)
        else
          raise "That type of random variate generator (#{species_class}) could not be found!"
        end
      end
    METHOD_DEF
  end

  def initialize(options = {})
    # Set default values.
    @store_values = false
    prepopulate_attrs(options)
  end

  def species
    self.class.name.to_s.gsub("RandomVariate", '').downcase.to_sym
  end

  # This function is used on the testing framework to test individual
  # random variate generators.
  def self.chi_square_statistic(actual_data, expected_data_divisions)
    # We don't want to affect the original array.
    data_points = actual_data.dup
    # This is how many data points we expect to fall in each range.
    expected_value = (data_points.length / (expected_data_divisions.length - 1))
    # Take the first value as the start_point of the range.
    opening_of_range = expected_data_divisions.shift
    data_points.reject!{|data_point| data_point <= opening_of_range}
    expected_data_divisions.collect do |end_point|
      (data_points.shave! do |data_point|
        # Find the number of data points that fall within this range.
        data_point <= end_point
      end.to_f - expected_value) ** 2 / expected_value
    end.sum
  end
end

require File.join( File.dirname(__FILE__), 'random_variate', 'exponential' )
require File.join( File.dirname(__FILE__), 'random_variate', 'normal' )
require File.join( File.dirname(__FILE__), 'random_variate', 'uniform' )
