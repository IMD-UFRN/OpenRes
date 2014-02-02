Backbone.ajax = function() {
   var args = Array.prototype.slice.call(arguments);
   args[0].url += '.json';
   return Backbone.$.ajax.apply(Backbone.$, args);
};

var PlaceModel = Backbone.Model.extend({
  urlRoot: '/places',

  defaults: {
    name: 'Nenhuma sala selecionada'
  }
});
