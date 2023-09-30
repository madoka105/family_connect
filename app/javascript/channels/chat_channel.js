/* global $*/
/* global location*/
import consumer from "./consumer"

if (!(location.pathname.includes('admin') || location.pathname == '/')) {
  const appChat = consumer.subscriptions.create("ChatChannel", {
    connected() {
      //Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      let insertText = ""
      let my_image  = `<img src="${$("#user_image").attr('src')}">`;
      let partner_image = `<img src="${$("#partner_image").attr('src')}">`;
      let my_name = $("#current_user_name").val();
      let partner_name = $("#partner_name").val();
      let partner_id = $("#partner_id").val();
      // console.log(data,data.sentence)
      // 画面を開いているのがチャット送信者だった場合
      if (data["isCurrent_user"] == true) {

        insertText = `
            <div class="fukidasi">
              <div class="mycomment">
                <div class="text-right">
                  ${my_image}
                  <div class="name">${my_name}</div>
                </div>
                <p>${data.sentence}</p>
              </div>
            </div>
        `;
      }
      // 画面を開いているのがチャット受信者だった場合
      else if (partner_id == data.send_user) {
        insertText = `
            <div class="fukidasi">
              <div class="text-left">
                  ${partner_image}
              </div>
              <div class="chatting">
                <div class="name">
                  ${partner_name}
                </div>
                <div class="says">
                <p>${data.sentence}</p>
                </div>
              </div>
            </div>
        `;
      } else {
        return false;
      }
      $("#chats").append(insertText);
      // Called when there's incoming data on the websocket for this channel
      setTimeout(function(){
        var objDiv = document.getElementById("chat_container");
        objDiv.scrollTop = objDiv.scrollHeight;
      },200)

    },

    speak(sentence) {
      const current_user_id = $("#current_user_id").val();
      const partner_id = $("#partner_id").val();
      // console.log(sentence, "hoge2");
      return this.perform("speak", {
        sentence: sentence,
        current_user_id: current_user_id,
        partner_id: partner_id,
      });
    },
  });

  $(function () {
    $("#send").on("click", function (e) {
      const sentence = $("#sentence");
      // console.log(sentence, "hoge");
      appChat.speak(sentence.val());
      sentence.val(""); // フォームを空に
      e.preventDefault();
    });
  });
}

