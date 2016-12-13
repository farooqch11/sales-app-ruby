require 'rails_helper'

RSpec.describe "expenses/index", :type => :view do
  before(:each) do
    assign(:expenses, [
      Expense.create!(
        :attachment => "Attachment",
        :purpose => "MyText",
        :type => "Type"
      ),
      Expense.create!(
        :attachment => "Attachment",
        :purpose => "MyText",
        :type => "Type"
      )
    ])
  end

  it "renders a list of expenses" do
    render
    assert_select "tr>td", :text => "Attachment".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
