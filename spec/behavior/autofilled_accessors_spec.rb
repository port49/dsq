require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

class TestAutofilledAccessorsBehavior
  attr_accessor :dummy_value
  
  def initialize( options = {}, &block )
    prepopulate_attrs( options )
  end
end

describe "AutofilledAccessors" do

  it "should autofill values for which the class has an accessor" do
    test_class = TestAutofilledAccessorsBehavior.new( :dummy_value => 3.14 )
    test_class.dummy_value.should ==( 3.14 )
  end

end

