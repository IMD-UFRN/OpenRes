var ready = function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Nenhum resultado para'
  });

  var placeModel = new PlacePreviewModel({});
  var placeView = new PlacePreviewView({ model: placeModel });
};

$(document).ready(ready);
$(document).on('page:load', ready);