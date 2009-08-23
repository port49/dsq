# This is behavior gives us the convenience of sending a hash to a new 
# instance of an object, and having the instance attributes that correspond
# to the hash keys be automatically prepopulated with the hash values.
module AutofilledAccessors

  # Cycle through the options Hash and set any instance variables that overlap
  # with the option keys.
  #
  # @param [Hash] options to prepopulate
  # @return [Object] self with the instance variables set
  def prepopulate_attrs( options )
    options.each do |key, value|
      if( self.methods.include?( ( key.to_s + '=' ).to_sym ) || self.methods.include?( key.to_s + '=' ) )
        self.send( ( key.to_s + '=' ).to_sym, value )
      end
    end
    return self
  end

end

class Object

  include( AutofilledAccessors )

end

