require 'spec_helper'

describe "containers/new" do
  before(:each) do
    assign(:container, stub_model(Container,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new container form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => containers_path, :method => "post" do
      assert_select "input#container_name", :name => "container[name]"
    end
  end
end
