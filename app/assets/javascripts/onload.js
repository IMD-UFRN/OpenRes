$(document).on('page:change', function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched'
  });

  $('.datetime_picker').datetimepicker({});
});