require 'spec_helper'

describe "plans/edit" do
  before(:each) do
    @plan = assign(:plan, stub_model(Plan,
      :title => "MyString"
    ))
  end

  it "renders the edit plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do
      assert_select "input#plan_title[name=?]", "plan[title]"
    end
  end
end
