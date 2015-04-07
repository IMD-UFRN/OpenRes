$("#modal-window").html("<%= escape_javascript(render 'import_suggestions_spreadsheet', url: @url) %>");
$("#modal-window").modal();
