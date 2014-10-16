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

  $(".mass-action-btn").on('click', function(e){
    e.preventDefault();

    var list = [];

    var el = $(e.currentTarget);

    var checkboxes = $(el).parent().parent().parent().find("input");

    for(var i = 0; i < checkboxes.length; i++){

      var check = $(checkboxes[i]);

      if(check.prop("checked")){

        list.push(check.data("id"));

      }
    }

    if (el.text() == "Aprovar Selecionadas" || el.text() == "Cancelar Selecionadas" || el.text() == "Excluir Selecionadas"){
      $.ajax({
        type: "POST",
        url: el.attr("href"),
        data: {reservations: list.join()},
        datatype: 'script',
        error: function(xhr, error){
          console.debug(xhr); console.debug(error);
        },
      });
    }
    else{
      console.log(list.join());
      $.ajax({
        type: "GET",
        url: el.attr("href"),
        data: {reservations: list.join()},
        datatype: 'script',
        error: function(xhr, error){
          console.debug(xhr); console.debug(error);
        },
      });
    }

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

  if (list[0] == ''){
    list = [];
  }

  if (reservation_id == -1){
     list.push(id.toString());
  }
  else{
    list.splice(reservation_id, 1);
  }

  btns.data("reservations", list.join());

  btns.attr("href", btns.attr("href").split("/")[0] + "/" + list.join())
}

var selected = false;

function toggleSelectAll(el){

  selected = !selected;

  var checkboxes = $(el).parent().parent().parent().find("input").prop('checked', selected);



}
