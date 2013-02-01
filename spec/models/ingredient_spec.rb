require 'spec_helper'

describe Ingredient do

  it "requires a name" do
    subject.valid?.should be(false)
  end

end
