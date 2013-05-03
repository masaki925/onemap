require 'spec_helper'

describe "spots/edit" do
  before(:each) do
    @spot = assign(:spot, stub_model(Spot,
      :name => "MyString"
    ))
  end

  it "renders the edit spot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spot_path(@spot), "post" do
      assert_select "input#spot_name[name=?]", "spot[name]"
    end
  end
end
