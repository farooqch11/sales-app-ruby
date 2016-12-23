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
//= require jquery.min
//= require bootstrap.min
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
//= require charts/easypiechart/jquery.easy-pie-chart
//= require charts/sparkline/jquery.sparkline.min
//= require charts/flot/jquery.flot.min
//= require charts/flot/jquery.flot.tooltip.min
//= require charts/flot/jquery.flot.resize
//= require charts/flot/jquery.flot.orderBars
//= require charts/flot/jquery.flot.pie.min
//= require charts/flot/jquery.flot.grow
//= require charts/flot/demo
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
//= require combodate/combodate
//= require main
//= require easyResponsiveTabs
//= require flash
//= require data-confirm-modal

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
    $('#horizontalTab').easyResponsiveTabs({
        type: 'default', //Types: default, vertical, accordion
        width: 'auto', //auto or any width like 600px
        fit: true   // 100% fit in a container
    });
});
