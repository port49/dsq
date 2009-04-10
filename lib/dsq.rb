require File.join( File.dirname(__FILE__), 'random_variate' )
require File.join( File.dirname(__FILE__), 'array' )
require File.join( File.dirname(__FILE__), 'simulation' )
require File.join( File.dirname(__FILE__), 'queue' )
require File.join( File.dirname(__FILE__), 'population' )

module DSQ
  class Error < RuntimeError; end
  class RandomVariateError < Error; end
end
