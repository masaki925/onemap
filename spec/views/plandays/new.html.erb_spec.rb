require 'spec_helper'

describe "plandays/new" do
  before(:each) do
    assign(:planday, stub_model(Planday,
      :plan => nil,
      :day => 1
    ).as_new_record)
  end

  it "renders new planday form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plandays_path, "post" do
      assert_select "input#planday_plan[name=?]", "planday[plan]"
      assert_select "input#planday_day[name=?]", "planday[day]"
    end
  end
end
