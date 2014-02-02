var PlaceView = Backbone.View.extend({
  render: function() {
    var html = '<p>' + this.model.get('name') + '</p>';
    $(this.el).html(html);
  }
});