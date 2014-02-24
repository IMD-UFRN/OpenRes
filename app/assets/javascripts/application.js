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
//= require bootstrap-modal
//= require bootstrap-datetimepicker
//= require chosen-jquery
//= require turbolinks
//= require moment
//= require moment/pt-br.js
//= require handlebars
//= require_tree .

Handlebars.registerHelper("prettifyDate", function(timestamp) {
  timestamp = timestamp.slice(0, -1);
  return moment(timestamp).format("HH:mm");
});

Handlebars.registerHelper("prettyStatus", function(status) {
  if (status == "approved")
    return "aprovada";
  else if (status == "rejected")
    return "rejeitada";
  else if (status == "pending")
    return "em aberto";

  return "?";
});