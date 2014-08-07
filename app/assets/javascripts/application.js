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
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/open_res
//= require bootstrap
//= require bootstrap-modal
//= require bootstrap-datetimepicker
//= require chosen-jquery
//= require turbolinks
//= require moment
//= require moment/pt-br.js
//= require handlebars
//= require jquery_nested_form
//= require_tree .

Handlebars.registerHelper("prettifyDate", function(timestamp) {
  timestamp = timestamp.slice(0, -1);
  return moment(timestamp).format("HH:mm");
});

Handlebars.registerHelper("placeLink", function(id) {
  return "/places/" + id;
});

Handlebars.registerHelper("prettyStatus", function(status) {
  if (status == "approved")
    return "Aprovada";
  else if (status == "rejected")
    return "Rejeitada";
  else if (status == "pending")
    return "Pendente";

  return "?";
});

var ready;
ready = function() {

  $('.accordion .head').click(function() {

    $(this).next(".slide-hidden").toggle('fast');
    return false;
  }).next(".slide-hidden").hide();

  $(window).scroll(function(){
      var scrollTop = $(window).scrollTop();
      if(scrollTop != 0)
          $('.navbar').stop().animate({'opacity':'0.2'},50);
      else
          $('.navbar').stop().animate({'opacity':'1'},50);
  });

  $('.navbar').hover(
      function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
              $('.navbar').stop().animate({'opacity':'1'},50);
          }
      },
      function (e) {
          var scrollTop = $(window).scrollTop();
          if(scrollTop != 0){
              $('.navbar').stop().animate({'opacity':'0.2'},50);
          }
      }
  );

};

$(document).ready(ready);
$(document).on('page:load', ready);
