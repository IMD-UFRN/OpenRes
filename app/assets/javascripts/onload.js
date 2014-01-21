var ready = function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Nenhum resultado para'
  });

  $('.date_picker').datetimepicker({
    pickTime: false
  });
  
  $('.time_picker').datetimepicker({
    pickDate: false
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);