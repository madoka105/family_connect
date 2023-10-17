// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

// チャンネルモジュールを自動的にロードするためのコード
const channels = require.context('.', true, /_channel\.js$/)

// require.contextで定義されたファイルパターンに一致するすべてのモジュールを検索して取得
channels.keys().forEach(channels)
