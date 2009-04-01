class RandomVariate

  # We use a Factory Pattern to return a particular species of RandomVariate.
  [ :exponential, :normal, :uniform ].each do|species|
    species_class = species.to_s.capitalize + "RandomVariate"

    # Define this species as a class method.
    class_eval <<-METHOD_DEF
      def self.#{ species }( *args )
        if Object.constants.include? :#{ species_class }
          return #{ species_class }.new( *args )
        else
          raise "That type of random variate generator (#{ species_class }) could not be found!"
        end
      end
    METHOD_DEF

  end
  
  def initialize( *args )
  end
  
  def species
    self.class.name.to_s.gsub( "RandomVariate", '' ).downcase.to_sym
  end
  
end

require 'random_variate/exponential'
require 'random_variate/normal'
require 'random_variate/uniform'

