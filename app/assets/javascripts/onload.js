function xinspect(o,i){
    if(typeof i=='undefined')i='';
    if(i.length>50)return '[MAX ITERATIONS]';
    var r=[];
    for(var p in o){
        var t=typeof o[p];
        r.push(i+'"'+p+'" ('+t+') => '+(t=='object' ? 'object:'+xinspect(o[p],i+'  ') : o[p]+''));
    }
    return r.join(i+'\n');
}


function build_url(place_id, date) {
  var result = 'http://localhost:3000/places/preview/?place_id=' + place_id;

  if (date) {
    result += '&date=' + date;
  }

  return result + '&locale=pt-BR'
}

var ready = function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Nenhum resultado para'
  });

  $('#place_selector').on('change', function(evt, params) {

    $.get(build_url(params.selected, $('#reservation_date').val()), function(data) {
        $('#place_preview').html(data);
    });

  });
};

$(document).ready(ready);
$(document).on('page:load', ready);