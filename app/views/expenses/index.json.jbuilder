json.array!(@expenses) do |expense|
  json.extract! expense, :id, :attachment, :start_date, :end_date, :purpose, :paid_time, :type
  json.url expense_url(expense, format: :json)
end
