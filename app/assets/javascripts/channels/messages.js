App.messages = App.cable.subscriptions.create('MessagesChannel', {
    received: function(data) {
        this.cleanInput("#message_text");
        this.mentionNotification(data);
        return this.appendMessage("#messages", data);
    },

    renderMessage: function(data) {
        var currentdate = new Date();
        var time = ('0' + currentdate.getHours()).slice(-2) + ':'
            + ('0' + currentdate.getMinutes()).slice(-2) + ':'
            + ('0' + currentdate.getSeconds()).slice(-2);
        var chat_side = (data.username == $('#message_username').val()) ? 'left' : 'right';
        var message = '<li class="message ' + chat_side + '">'
            + '<div class="img-thumbnail avatar ' + data.dialect + '"></div>'
            + '<div class="text_wrapper">'
            + '<span class="username">' + data.username + '</span>'
            + '<span class="time float-right">' + time + '</span>'
            + '<div class="text">'
            + data.message
            + '</div>'
            + '</div>'
            + '</li>';
        return message;
    },

    appendMessage: function(elem, data){
        $(elem).append(this.renderMessage(data));
        $(elem).children("li:last").hide().fadeIn(900);
        scroller(elem);
    },

    mentionNotification: function(data){
        var rows = data.mentions;
        var self_mentioned = false;
        var already_mentioned = [];

        for (var i = 0; i < rows.length; i++) {
            var mentions = rows[i];
            for (var k = 0; k < mentions.length; k++) {
                var mention = mentions[k];
                self_mentioned = (data.username == mention.username) ? true : false;
                if ($.inArray(mention.username, already_mentioned ) < 0 && self_mentioned == false && mention.username == $('#message_username').val()){
                    console.log('@'+data.username+' have mentioned @'+mention.username);
                    already_mentioned.push(mention.username);
                    alert('@'+data.username+' have mentioned you');
                }
            }
        }
    },

    cleanInput: function(elem) {
        $(elem).val('');
    }
});
