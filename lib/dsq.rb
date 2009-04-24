# Pull in all of our library files.
[
  'random_variate',
  'array',
  'simulation',
  'queue',
  'population',
  'server',
  'item' 
].each do |library_name|
  require File.join( File.dirname(__FILE__), library_name )
end

module DSQ
  class Error < RuntimeError; end
  class RandomVariateError < Error; end
end
