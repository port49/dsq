class RandomVariate
  # If this is set, we store the generated values in an array, perhaps
  # to re-run a series using the same random variates.
  attr_accessor :store_values

  # Provide a class for errors.
  class Error < Exception; end

  # We use a Factory Pattern to return a particular species of RandomVariate.
  [ :exponential, :normal, :uniform ].each do|species|
    species_class = species.to_s.capitalize + "RandomVariate"

    # Define this species as a class method.  Note that Ruby1.9+ defines constants
    # as symbols, while earlier versions use strings.
    class_eval <<-METHOD_DEF
      def self.#{ species }( *args )
        if( Object.constants.include?( :#{ species_class } ) || Object.constants.include?( "#{ species_class }" ) )
          return #{ species_class }.new( *args )
        else
          raise "That type of random variate generator (#{ species_class }) could not be found!"
        end
      end
    METHOD_DEF
  end
  
  def initialize( options = {} )
    # Set default values.
    @store_values = false
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.instance_variables.include?( ( "@" + key.to_s ).to_sym ) || instance_variables.include?( "@" + key.to_s ) )
        instance_variable_set ( "@" + key.to_s ).to_sym, value
      end
    end
  end
  
  def species
    self.class.name.to_s.gsub( "RandomVariate", '' ).downcase.to_sym
  end
  
  # This function is used on the testing framework to test individual 
  # random variate generators.
  def self.chi_squared_coefficient( actual_data, expected_data_divisions )
    # This is how many data points we expect to fall in each range.
    expected_value = ( actual_data.length / ( expected_data_divisions.length - 1 ) )
    # Take the first value as the start_point of the range.
    start_point = expected_data_divisions.unshift
    expected_data_divisions.each do |end_point|
      ( actual_data.select do |data_point|
        # Find the number of data points that fall within this range.
        ( start_point < data_point ) &&
        ( data_point <= end_point )
      end.length - expected_value ) ** 2 / expected_value
      start_point = end_point
    end.sum


=begin
    for( i = 0; i < expected_data_divisions; i += 1 )
    end.sum
    }
    ( 0..9 ).collect do |integer|
      ( @random.select{ |i| i == integer }.length - @e ).to_f ** 2 / @e 
    end.sum
  end
  
  # Fail to reject the null hypothesis that there is no significant
  # difference between the expected and the actual frequencies.  True 
  # is rejection of null hypothesis -- the higher the number, the more
  # surely we reject the null hypothesis and conclude opposite, which is that
  # there is a difference, hence not random.  False is failure to reject null
  # hypothesis -- therefore, it could be true, therefore may be random.
  it "should have expected frequency according to chi squared (alpha=0.05)" do
    @e = ( @random.length / 10 )
    ( ( 0..9 ).collect do |integer|
      ( @random.select{ |i| i == integer }.length - @e ).to_f ** 2 / @e 
    end.inject { |sum, n| sum + n } > 16.919 ).should be_false
=end
  end
  
end

require File.join( File.dirname(__FILE__), 'random_variate', 'exponential' )
require File.join( File.dirname(__FILE__), 'random_variate', 'normal' )
require File.join( File.dirname(__FILE__), 'random_variate', 'uniform' )

