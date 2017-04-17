App.users = App.cable.subscriptions.create('UsersChannel', {
    received: function(data) {
        console.log(data.status +':'+ data.username );
        this.messageNotification(data);
        if(data.status == 'activate' && !$("#user-" + data.username).length ){
            return $('#users').append(this.renderUser(data));
        }else{
            return $('#user-'+data.username).remove();

        }
    },
    renderUser: function(data) {
        var user = '<li class="list-group-item" id="user-'+data.username+'">'
        + '<div class="row">'
                 + '<div class="col-md-2 img-thumbnail avatar '+data.dialect+'"></div>'
                 + '<div class="col p-2">'
                 + '<span class="name">' + data.username + '</span><br/>'
                 + '</div>'
        + '</div>'
               + '</li>';

        return user;
    },
    messageNotification: function(data) {
      var currentdate = new Date();
      var show_notification = (data.username != $('#message_username').val()) ? true : false;
      var time = ('0' + currentdate.getHours()).slice(-2) + ':'
            + ('0' + currentdate.getMinutes()).slice(-2) + ':'
            + ('0' + currentdate.getSeconds()).slice(-2);
      var message = '<li class="message '+data.status+' notification">'
          + '<div class="status_text">'
          + '<b>@' + data.username + '</b> '
          + ( (data.status=='activate') ? 'connected' : 'disconnected' )
          + '<span class="float-right">' + time + '</span>'
          + '</div>'
          + '</li>';
        if (show_notification)
          $('#messages').append(message).fadeIn('slow');
    }
});
