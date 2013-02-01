require 'spec_helper'

describe "sandwiches/index" do
  before(:each) do
    assign(:sandwiches, [
      stub_model(Sandwich),
      stub_model(Sandwich)
    ])
  end

  it "renders a list of sandwiches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
