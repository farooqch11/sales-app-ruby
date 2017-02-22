// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require fusioncharts/fusioncharts
//= require fusioncharts/fusioncharts.charts
//= require fusioncharts/themes/fusioncharts.theme.fint
//= require parsley/parsley.extend
//= require jquery.validate.min
//= require jquery.validate.extended
//= require amaran/jquery.amaran
//= require amaran/jquery.amaran.min
//= require parsley/parsley.min
//= require app
//= require app.plugin
//= require slimscroll/jquery.slimscroll.min
//= require appear/jquery.appear
//= require scroll/smoothscroll
//= require landing
//= require calendar/bootstrap_calendar
//= require calendar/demo
//= require sortable/jquery.sortable
//= require libs/underscore-min
//= require fuelux/fuelux
//= require fuelux/demo.datagrid
//= require select2/select2.min
//= require sweetalert.min
//= require awesomplete.min
//= require datepicker/bootstrap-datepicker
//= require daterangepicker/moment
//= require daterangepicker/daterangepicker
//= require combodate/combodate
//= require main
//= require flash
//= require data-confirm-modal
//= require finance
//= require reports
//= require invoice
//= require rails.validations
(function($) {
    $.fn.equalHeights = function() {
        var maxHeight = 0,
            $this = $(this);

        $this.each( function() {
            var height = $(this).innerHeight();

            if ( height > maxHeight ) { maxHeight = height; }
        });

        return $this.css('height', maxHeight);
    };

    // auto-initialize plugin
    $('[data-equal]').each(function(){
        var $this = $(this),
            target = $this.data('equal');
        $this.find(target).equalHeights();
    });

})(jQuery);
$(document).ready(function () {
    $(function(){
        $('div.product-chooser').not('.disabled').find('div.product-chooser-item').on('click', function(){
            $(this).parent().parent().find('div.product-chooser-item').removeClass('selected');
            $(this).addClass('selected');
            $(this).find('input[type="radio"]').prop("checked", true);

        });
    });
    $(function() {

        var start = moment().subtract(29, 'days');
        var end = moment();

        function cb(start, end) {
            $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        }

        $('#reportrange').daterangepicker({
            startDate: start,
            endDate: end,
            ranges: {
                'Today':        [moment(), moment()],
                'Yesterday':    [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days':  [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                'This Month':   [moment().startOf('month'), moment().endOf('month')],
                'Last Month':   [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        }, cb);

        cb(start, end);

    });
});

$(document).on("page:load ready", function(){
    $("input.datepicker").datepicker();
});