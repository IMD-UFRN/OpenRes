var PlacePreviewModel = Backbone.Model.extend({
  urlRoot: '/places/',

  url: function() {
    if (!this.id)
      return "#";

    console.log(this.get('end_time'));
    return this.urlRoot + this.id + "/get_reservations.json" +
      "?date=" + this.get('date') + "&begin_time=" + this.get('begin_time') + "&end_time=" + this.get('end_time')  ;


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
