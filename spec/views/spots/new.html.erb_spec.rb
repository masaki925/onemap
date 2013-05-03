require 'spec_helper'

describe "spots/new" do
  before(:each) do
    assign(:spot, stub_model(Spot,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new spot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spots_path, "post" do
      assert_select "input#spot_name[name=?]", "spot[name]"
    end
  end
end
