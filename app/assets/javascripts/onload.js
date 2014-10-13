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

function toggleReservation(el, id){
  var btns = $(el).parent().parent().parent().find(".mass-action-btn");

  var list =  btns.data("reservations").split(",");

  var reservation_id = list.indexOf(id.toString());

  console.log(list);

  if (reservation_id == -1){
     list.push(id);
  }
  else{
    list.splice(reservation_id, 1);
  }

  btns.data("reservations", list.join());
  btns.text(list.join());
}
