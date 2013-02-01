require 'spec_helper'

describe Container do

  it "requires a name" do
    subject.valid?.should be(false)
  end

end
