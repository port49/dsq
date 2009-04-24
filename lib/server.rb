# Instances of the Server class are often used to respond to items in Queues.
class Server

  def initialize( options = {}, &block )
    # Set default values.
    
    # Cycle through the options Hash and set any instance variables that overlap
    # with the option keys.
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end
  end

end

