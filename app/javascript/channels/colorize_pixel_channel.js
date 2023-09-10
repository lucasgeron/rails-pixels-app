import consumer from "channels/consumer"

window.btn_job = document.getElementById('btn-job');

consumer.subscriptions.create("ColorizePixelChannel", {
  connected() {
    // console.log("Connected to the colorize_pixel_channel");
  },

  disconnected() {
    // console.log("Disconnected from the colorize_pixel_channel");
    window.btn_job.innerHTML = 'Colorize Job';
    window.btn_job.className = 'btn-primary';
  },

  received(data) {
    // console.log("Received data from the colorize_pixel_channel");
    switch (data.command) {
      case 'disconnect':
        return this.disconnected();
      default:
        window.btn_job.innerHTML = 'Colorizing: ' + data.index + ' / ' + data.total;
        window.btn_job.className = 'btn-primary bg-blue-600 text-white pointer-events-none animate-pulse';

        let pixels = document.getElementsByClassName('pixel_' + data.pixel.id);
        for (var i = 0; i < pixels.length; i++) {
          pixels[i].className = 'pixel pixel_' + data.pixel.id + ' ' + data.pixel.color;
        }
        
        break;
    }
  }
});
