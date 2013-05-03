require 'spec_helper'

describe "plandays/edit" do
  before(:each) do
    @planday = assign(:planday, stub_model(Planday,
      :plan => nil,
      :day => 1
    ))
  end

  it "renders the edit planday form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", planday_path(@planday), "post" do
      assert_select "input#planday_plan[name=?]", "planday[plan]"
      assert_select "input#planday_day[name=?]", "planday[day]"
    end
  end
end
