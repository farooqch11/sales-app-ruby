require 'rails_helper'

RSpec.describe "expenses/show", :type => :view do
  before(:each) do
    @expense = assign(:expense, Expense.create!(
      :attachment => "Attachment",
      :purpose => "MyText",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Attachment/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Type/)
  end
end
