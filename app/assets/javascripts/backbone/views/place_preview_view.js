var PlacePreviewView = Backbone.View.extend({
  el: '#new_reservation',

  initialize: function() {
    this.render();
    this.model.on('change', this.render, this);
  },

  events: {
    'change #reservation_date' : 'updatePreview',
    'change #place_selector' : 'updatePreview'
  },

  render: function() {
    var source = $('#place_preview_template').html();

    if (!source)
      return;

    var template = Handlebars.compile(source);
    var html = template(this.model.toJSON());
    this.$el.find('#place_preview').html(html);
  },

  updatePreview: function(evt) {
    var that = this;
    var selected = $('#place_selector').val();

    var split = $('#reservation_date').val().split('/');

    var year = parseInt(split[2]);
    var month = parseInt(split[1]) - 1;
    var day = parseInt(split[0]);

    var date = moment([year, month, day]);

    if (!date.isValid())
      date = moment();

    $('#reservation_date').val(date.format('DD/MM/YYYY'));

    this.model.set({id: selected, date: date.format('DD/MM/YYYY')});

    this.model.fetch({
      success: function (collection, response) {
        console.log(response);

        that.model.set(response);
        that.render();
      }
    });
  }
});