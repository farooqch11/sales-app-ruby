require 'rails_helper'
describe ApplicationHelper do

  before(:each) do
    @sale = FactoryGirl::create(:sale)
    @payment = FactoryGirl::create(:payment)
  end
  describe "#payment" do
    it "returns payment_total" do
      expect(helper.payment_total).to eq 15.0
    end
  end

  describe "#raw_sales" do
    it "returns total" do
      expect(helper.raw_sales).to eq 17.0
    end
  end
end
