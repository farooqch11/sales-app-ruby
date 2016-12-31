require 'rails_helper'

RSpec.describe "expenses/new", :type => :view do
  before(:each) do
    assign(:expense, Expense.new(
      :attachment => "MyString",
      :purpose => "MyText",
      :type => ""
    ))
  end

  it "renders new expense form" do
    render

    assert_select "form[action=?][method=?]", expenses_path, "post" do

      assert_select "input#expense_attachment[name=?]", "expense[attachment]"

      assert_select "textarea#expense_purpose[name=?]", "expense[purpose]"

      assert_select "input#expense_type[name=?]", "expense[type]"
    end
  end
end