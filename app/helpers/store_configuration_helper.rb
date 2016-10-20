module StoreConfigurationHelper
  def currencies
  	cur = YAML.load_file('config/currencies.yml')
  	cur.map{|r| [ r[0], r[1] ]}.sort
  end

end