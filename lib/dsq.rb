require File.join( File.dirname(__FILE__), 'random_variate' )
require File.join( File.dirname(__FILE__), 'array' )

module DSQ
  class Error < RuntimeError; end
  class RandomVariateError < Error; end
end
