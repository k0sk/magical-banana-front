<app>
  <div class="container">
    <div class="text-center">
      <h1>{ opts.title }</h1>
      <p class="lead">〇〇と言ったら××</p>
      <form name="chat_form" class="form-inline" onSubmit={ send }>
        <div class="form-group">
          <input type="text" name="chat_input" class="form-control" onkeyup={ input } placeholder="メッセージ" size="60">
        </div>
        <button disabled={ !text } class="btn btn-primary">送信</button>
      </form>
    </div>
    <div class="media" each={ items }>
      <div class="media-left" if={ icon_emoji == ':banana:'}>
        {icon_emoji}
      </div>
      <div class="media-body">
        <h4 class="media-heading">{ username }</h4>
        <p>{ text }</p>
      </div>
      <div class="media-right" if={ icon_emoji != ':banana:'}>
        {icon_emoji}
      </div>
    </div>
  </div>

  <script>
  this.text = '';
  this.disabled = true;
  this.items = opts.items;

  // input text-box check
  input(e) {
    this.text = e.target.value;
  }

  // add message
  send(e) {
    new_message = {
      'username': 'ゲスト',
      'text': this.text,
      'icon_emoji': ':tophat:'
    };
    opts.items.unshift(new_message);

    fetch('http://mbanana.kosk.me/api?q=' + this.text)
    .then(function(res) {
      return res.json();
    })
    .then(function(json) {
      opts.items.unshift(json);
      riot.update();
    });

    this.text = '';
    document.chat_form.chat_input.value = '';
  }

  this.on('update', function() {
    opts.emojify.run();
  });
  </script>
</app>
