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
    var beginTime = moment($('#reservation_begin_time').val(), "HH:mm").add('minutes', 60)

    if (!date.isValid())
      date = moment();

    if (!beginTime.isValid()) {
      if (moment().get('minutes') < 30){
        $('#reservation_begin_time').val(moment().add('minutes', 30 - moment().get('minutes')).format("HH:mm"));
        $('#reservation_end_time').val(moment().add('minutes', 30 - moment().get('minutes')+ 60).format("HH:mm"));
      }
      else{
        $('#reservation_begin_time').val(moment().add('minutes', 60 - moment().get('minutes')).format("HH:mm"));
        $('#reservation_end_time').val(moment().add('minutes', 120 - moment().get('minutes')).format("HH:mm"));
      }
      //$('#reservation_begin_time').val(moment().format("HH:mm"));
      //$('#reservation_end_time').val(moment().add('minutes', 60).format("HH:mm"));
    }
    else {
      if (!moment($('#reservation_end_time').val(), "HH:mm").isValid())
        $('#reservation_end_time').val(beginTime.format("HH:mm"));
    }

    $('#reservation_date').val(date.format('DD/MM/YYYY'));

    this.model.set({id: selected, date: date.format('DD/MM/YYYY'), begin_time: beginTime.format("HH:mm"), end_time: $('#reservation_end_time').val()});

    this.model.fetch({
      success: function (collection, response) {
        console.log(response);

        that.model.set(response);
        that.render();
      }
    });
  }
});
