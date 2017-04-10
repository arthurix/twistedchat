App.users = App.cable.subscriptions.create('UsersChannel', {  
    received: function(data) {
      if( !$("#user-" + data.username).length )
        return $('#users').append(this.renderUser(data));
  },
  renderUser: function(data) {
    return "<p id='user-" + data.username + "'><b>" +
      data.username + "</b></p>";
  }
});
