var PlacePreviewModel = Backbone.Model.extend({
  urlRoot: '/places/',

  url: function() {
    if (!this.id)
      return "#";

    return this.urlRoot + this.id + "/get_reservations.json" + 
      "?date=" + this.get('date');
  },

  defaults: function() {
    return {
      name: 'Nenhuma sala selecionada',

      date: function() {
        return moment(new Date()).format('DD/MM/YYYY');
      },

      reservations: [],

      capacity: '-'
    }
  }
});
