navigator.getUserMedia  = navigator.getUserMedia ||
                          navigator.webkitGetUserMedia ||
                          navigator.mozGetUserMedia ||
                          navigator.msGetUserMedia;

var video = document.querySelector('video');
var canvas = document.querySelector('canvas');
var takePhotoButton = document.querySelector('#take-photo');
var ctx = canvas.getContext('2d');
var previewImg = document.querySelector('img');
var imageDataURL = document.querySelector('#image_data_url');
var countdown = document.getElementById('ctdn');
var savePhotoAlbum = document.querySelector('#save-photo')
var localMediaStream = null;

function snapshot() {
  if (localMediaStream) {
    ctx.drawImage(video, -90, 0);
    var dataURL = canvas.toDataURL('image/png');
    previewImg.src = dataURL;
    imageDataURL.value = dataURL;
  }
}

function startCountdown() {
  countdown.style.removeProperty('display');
  savePhotoAlbum.disabled = true;
  takePhotoButton.disabled = true;
  takePhotoButton.innerText = 'Counting down...';
  previewImg.src = '';

  var count = 4;
  countdown.innerText = count;

  var counter = setInterval(timer, 1000);

  function timer() {
    count--;
    if (count === 0) {
      countdown.style.setProperty('display', 'none');
      savePhotoAlbum.disabled = false;
      takePhotoButton.disabled = false;
      takePhotoButton.innerText = 'Retake Photo'
      clearInterval(counter);
      snapshot();
    }

    countdown.innerText = count;
  }
}

takePhotoButton.addEventListener('click', startCountdown, false);

if (navigator.getUserMedia) {
  navigator.getUserMedia({video: true}, function(stream) {
    video.src = window.URL.createObjectURL(stream);
    localMediaStream = stream;
  }, function(){console.log('Failed');});
} else {
  alert('Your browser is not supported.'); // fallback.
}
