module StoreConfigurationHelper
  def currencies
  	cur = YAML.load_file('config/currencies.yml')
  	cur.map{|r| [ r[0], r[1] ]}.sort
  end

  def value_in_currency value
    number_to_currency(value , unit: current_company.currency)
  end

end