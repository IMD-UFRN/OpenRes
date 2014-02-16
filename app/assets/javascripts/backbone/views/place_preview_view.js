var PlacePreviewView = Backbone.View.extend({
  el: '#new_reservation',

  initialize: function() {
    this.render();
    this.model.on('change', this.render, this);
  },

  events: {
    'changeDate .time_picker' : 'updatePreview',
    'changeDate .date_picker' : 'updatePreview',
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
    //dont fire events on reservation_end_time, only way to it works
    //if u remove the changeDate to only reservation_begin_time, the event isnt fired
    //if u remove this line, it will fire in the reservation_end_time timepicker
    if ($(evt.currentTarget).hasClass("reservation_end_time"))
      return;

    var that = this;
    var selected = $('#place_selector').val();

    var split = $('#reservation_date').val().split('/');

    var year = parseInt(split[2]);
    var month = parseInt(split[1]) - 1;
    var day = parseInt(split[0]);

    var date = moment([year, month, day]);
    var time = moment($('#reservation_begin_time').val(), "HH:mm").add('minutes', 30)

    if (!date.isValid())
      date = moment();

    $('#reservation_end_time').val(time.format("HH:mm"));

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