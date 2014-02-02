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


var ready = function() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Nenhum resultado para'
  });

  $('#place_selector').on('change', function(evt, params) {

    $.ajax("/places/" + params.selected + ".json").done(function(data) {
      // I'm only using extend to add in the id. You could just use data[0]
      var placeModel = new PlaceModel(data);
      var placeView = new PlaceView({ model: placeModel });
    
      placeView.render();

      $('#place_preview').html(placeView.$el);
    });

  //$.get('http://localhost:3000/places/preview/' + params.selected + '?locale=pt-BR', function(data) {
  //    $('#place_preview').html(data);
  //});

  });
};

$(document).ready(ready);
$(document).on('page:load', ready);