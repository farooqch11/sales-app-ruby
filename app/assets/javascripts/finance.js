$(document).ready(function() {
    $('table.highchart').highchartTable();
    function financial_position(el)
    {
        type  = $(".report-period-type option:selected").val();
        period= $(el).val();
        if(type && period) {
            $.post('/finance/financial_position', {type: type , period: period});
        }
    }
    $(".report-period-type").change(function(){
        period_type = $(".report-period-type option:selected").attr('class');
        $(".report-period-type > option").map(function() {
            if(period_type == $(this).attr('class'))
            {
                type   = $(this).val();
                period = $($(this).attr('class')).val();

                    $.post('/finance/financial_position', {type: type, period: period});
                    $(period_type).removeClass('hidden');

            }else{
                $($(this).attr('class')).addClass('hidden');
            }
        });
    });

    $("#report-period-years").change(function(){
        financial_position(this);
    });
    $("#report-period-months").change(function(){
        financial_position(this);
    });
    financial_position($("#report-period-years"));

});
