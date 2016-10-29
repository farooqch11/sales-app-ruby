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
//= require bootstrap
//= require app
//= require app.plugin
//= require slimscroll/jquery.slimscroll.min
//= require parsley/parsley.min
//= require parsley/parsley.extend
//= require jquery.validate.min
//= require jquery.validate.extended
//= require jquery.validate
//= require amaran/jquery.amaran
//= require amaran/jquery.amaran.min
//= require appear/jquery.appear
//= require scroll/smoothscroll
//= require landing

 function showWebUrl() {
     $("#web-url").show();
     $("#web-url").html("<b style='color:#424748;'>Company URL </b>- <b>http://" + $('#store_store_name').val().toLowerCase().replace(/ /g,'').replace(/[^\w-]+/g,'').replace(/[_]+/g,'-') + ".tend360.com</b>");
     $("#store_owner_attributes_username").val($('#store_store_name').val());
     if($('#store_store_name').val() == '')
         $("#web-url").hide();
 }
