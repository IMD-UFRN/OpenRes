var ready = function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    width: "300px",
    no_results_text: 'Nenhum resultado para'
  });

  $('.datetimepicker').datetimepicker({
    pickSeconds: false
  });

  $('.timepicker').datetimepicker({
    pickDate: false,
    pickSeconds: false
  });

  $('.datepicker').datetimepicker({
    pickTime: false
  });

  var placeModel = new PlacePreviewModel({});
  var placeView = new PlacePreviewView({ model: placeModel });
};

$(document).ready(ready);
$(document).on('page:load', ready);