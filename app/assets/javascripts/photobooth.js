navigator.getUserMedia  = navigator.getUserMedia ||
                          navigator.webkitGetUserMedia ||
                          navigator.mozGetUserMedia ||
                          navigator.msGetUserMedia;

var video = document.querySelector('video');
var canvas = document.querySelector('canvas');
var button = document.querySelector('button');
var ctx = canvas.getContext('2d');
var preview_img = document.querySelector('img');
var image_data_url = document.querySelector('#image_data_url');
var countdown = document.getElementById('countdown');
var localMediaStream = null;

function snapshot() {
  if (localMediaStream) {
    ctx.drawImage(video, 0, 0);
    var data_url = canvas.toDataURL('image/png');
    preview_img.src = data_url;
    image_data_url.value = data_url;
  }
}

function startCountdown() {
  countdown.style.removeProperty('display');
  button.innerText = 'Counting down...';

  // change count back to 5 when finished testing
  var count = 1;
  countdown.innerText = count;

  var counter = setInterval(timer, 1000);

  function timer() {
    count--;
    if (count === 0) {
      countdown.style.setProperty('display', 'none');
      button.innerText = 'Retake Photo'
      clearInterval(counter);
      snapshot();
    }

    countdown.innerText = count;
  }
}

button.addEventListener('click', startCountdown, false);

if (navigator.getUserMedia) {
  navigator.getUserMedia({video: true}, function(stream) {
    video.src = window.URL.createObjectURL(stream);
    localMediaStream = stream;
  }, function(){console.log('Failed');});
} else {
  alert('Your browser is not supported.'); // fallback.
}