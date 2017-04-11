App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden');
    this.scrollDown("#messages");
    $('#messages').append(this.renderMessage(data));
    return this.MessageAnimation("#messages");
  },
  renderMessage: function(data) {
    return "<p><b>" + data.user + ": </b><span>" + data.message + "</span></p>";
  },
  scrollDown: function(elem) {
    var scroller = $(elem);
    var height = scroller[0].scrollHeight - $(scroller).height() + 35;

    $(scroller).stop().animate({ scrollTop: height }, "slow");
  },
  MessageAnimation: function(elem){
      $(elem).children("p:last").hide().effect("highlight", {color:"#FFFCCF"}, 1500);
  }
});
