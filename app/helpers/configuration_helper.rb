module ConfigurationHelper
    def months_between_dates(date_1, date_2)
        diff_in_years  = (date_1.year-date_2.year)*12
        diff_in_months = date_1.month-date_2.month
        return (diff_in_years + diff_in_months).abs
    end

    def fusion_chart(xAxis , category , sales_data , expenses_data , profit_data)
        Fusioncharts::Chart.new({
                                    width: "100%",
                                    height: "400",
                                    type:  'mscombi2d',
                                    renderAt: "chartContainer",
                                    dataSource: {
                                        chart: {
                                            caption: "Comparison of Revenue",
                                            subCaption: current_location.name,
                                            xAxisname: xAxis,
                                            yAxisName: "Amount (#{current_company.currency})",
                                            numberPrefix: current_company.currency,
                                            theme: "fint",
                                            exportEnabled: "1",
                                        },
                                        categories: [
                                            {
                                                "category": category
                                            }
                                        ],
                                        "dataset": [
                                            {
                                                "seriesname": "Sale",
                                                "data": sales_data
                                            },
                                            {
                                                "seriesname": "Expense",
                                                "renderas": "line",
                                                "showvalues": "0",
                                                "data": expenses_data
                                            },
                                            {
                                                "seriesname": "Profit",
                                                "renderas": "area",
                                                "showvalues": "0",
                                                "data": profit_data
                                            }
                                        ]
                                    }
                                })
    end

    def finance_chart_by_month(sales , expense , month)
        category = []
        sales_data = []
        expenses_data = []
        profit_data   = []
        xAxis         = month.strftime('%B %Y')
        (month.beginning_of_month..month.end_of_month).each_with_index do |day , index|
            category.push(Hash["label" , day.strftime('%d')])
            sales_data.push(Hash["value" , sales.total_on(day , day).to_f])
            profit_data.push(Hash["value" , sales.total_profit(day , day).to_f])
            expenses_data.push(Hash["value" , expense.total_on(day , day).to_f ])

        end
        fusion_chart(xAxis , category , sales_data , expenses_data , profit_data)
    end

    def finance_chart_by_year(sales , expense , start_date = Date.today.beginning_of_year , end_date = Date.today)
        category = []
        sales_data = []
        expenses_data = []
        profit_data   = []
        month = start_date.beginning_of_month
        xAxis         = start_date.strftime('%B %Y') + " - " + end_date.strftime('%B %Y')
        (1..months_between_dates(start_date , end_date)).each do |index|

            date_s = month.beginning_of_month
            date_e = month.end_of_month
            category.push(Hash["label" , month.strftime('%b %y')])
            sales_data.push(Hash["value" , sales.total_on(date_s , date_e).to_f])
            profit_data.push(Hash["value" , sales.total_profit(date_s , date_e).to_f])
            expenses_data.push(Hash["value" , expense.total_on(date_s, date_e).to_f ])
            month += 1.month
        end
        fusion_chart(xAxis , category , sales_data , expenses_data , profit_data)
    end

 end
