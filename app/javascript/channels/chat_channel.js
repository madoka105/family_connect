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
      console.log(data.sentence)
      // 画面を開いているのがチャット送信者だった場合
      if (data["isCurrent_user"] == true) {
        insertText = `
          <div class="mycomment">
            <p>${data.sentence}</p>
          </div>
        `;
      }
      // 画面を開いているのがチャット受信者だった場合
      else {
        insertText = `
          <div class="fukidasi">
            <div class="chatting">
              <div class="says">
                <p>${data.sentence}</p>
              </div>
            </div>
          </div>
        `;
      }
      $("#chats").append(insertText); // Called when there's incoming data on the websocket for this channel
    },

    speak(sentence) {
      const current_user_id = $("#current_user_id").val();
      const partner_id = $("#partner_id").val();
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
      console.log(sentence)
      appChat.speak(sentence.val());
      sentence.val(""); // フォームを空に
      e.preventDefault();
    });
  });
}

