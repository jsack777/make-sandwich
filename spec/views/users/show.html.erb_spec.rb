require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :user_name => "User Name",
      :first_name => "First Name",
      :last_name => "Last Name",
      :password => "Password",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User Name/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Password/)
    rendered.should match(/Email/)
  end
end
