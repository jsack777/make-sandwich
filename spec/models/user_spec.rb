require 'spec_helper'

describe User do

  it "has a full_name" do
    u = User.new
    u.respond_to?(:full_name).should be(true)
  end

  it "falls back to email if full_name blank?" do
    user = User.first || create(:user)
    user.display_name.should eq("#{user.first_name} #{user.last_name}")
    user.first_name = nil
    user.last_name = nil
    user.display_name.should eq(user.email)
  end
end
