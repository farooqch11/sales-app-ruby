require 'rails_helper'

RSpec.describe "expenses/edit", :type => :view do
  before(:each) do
    @expense = assign(:expense, Expense.create!(
      :attachment => "MyString",
      :purpose => "MyText",
      :type => ""
    ))
  end

  it "renders the edit expense form" do
    render

    assert_select "form[action=?][method=?]", expense_path(@expense), "post" do

      assert_select "input#expense_attachment[name=?]", "expense[attachment]"

      assert_select "textarea#expense_purpose[name=?]", "expense[purpose]"

      assert_select "input#expense_type[name=?]", "expense[type]"
    end
  end
end
