# Pull in general Ruby behaviors.
Dir.glob( File.join( File.dirname(__FILE__), 'behavior', '*.rb' ) ).each do |file|
  require file
end
# Pull in all of our library files.
[
  'random_variate',
  'array',
  'event',
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
  class EventSchedulingError < Error; end
end
