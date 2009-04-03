require File.dirname(__FILE__) + '/../spec_helper'

describe "ExponentialRandomVariate" do

  it "should raise error if 'mean' value isn't supplied" do
    lambda{ RandomVariate.exponential }.should raise_error( DSQ::RandomVariateError, "You must supply a mean value to an exponential variate generator." )
  end

end

