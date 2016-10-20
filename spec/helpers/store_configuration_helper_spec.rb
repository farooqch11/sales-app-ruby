require "rails_helper"

describe StoreConfigurationHelper do

  describe "#currencies" do
    it "returns currencies as an array" do
      expect(helper.currencies[0]).to eq(["EURO (EUR)", "€"])
    end
  end
end