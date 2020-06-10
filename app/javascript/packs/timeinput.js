$(document).ready(function(){
  var timeInput = $('.realtime');
  setInterval(function(){
    var date = new Date()
    var hours = date.getHours() < 10 ? '0'+date.getHours() : date.getHours();
    var minutes = date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes();
    var seconds = date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds();
    timeInput.val(`${hours}:${minutes}:${seconds}`)
  }, 1000)
})