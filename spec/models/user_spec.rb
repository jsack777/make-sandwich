require 'spec_helper'

describe User do

  it "has a full_name" do
    u = User.new
    u.respond_to?(:full_name).should be(true)
  end

end
