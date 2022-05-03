
var inputmax = 640;

function msgInput(that) {
  var count = that.html().replace(/<div>/gi,'<br>').replace(/<\/div>/gi,'').replace(/(\r\n|\n|\r)/gm, "").length,
      remaining = inputmax - count,
      charcounter = that.closest('form').find(".message-input-count"); 

  if(remaining < 0) {
    $('.message-submit').prop('disabled', true);
  } else if (remaining == inputmax) {
    $('.message-submit').prop('disabled', true);
  } else {
    $('.message-submit').prop('disabled', false);
  }

  if(remaining <= 150) {
    charcounter.text("(" + remaining + ")");
  } else {
    charcounter.text("");
  }

}

$('#pm-input').on('keyup', function() {
  var that = $(this);
  msgInput(that);
}).on('paste', function(e){
  var that = $(this);
  e.preventDefault();
  setTimeout(function() {
    msgInput(that);
  }, 500);
})

const scroll_bottom = function() {
    $('#messages-container').scrollTop($('#messages-container')[0].scrollHeight);
};

scroll_bottom();

$('#new_personal_message').on('submit', function(){
    var typedtxt = document.getElementById('pm-input').innerHTML;
    var newtxt = typedtxt.replace(/<div>/gi,'<br>').replace(/<\/div>/gi,'').replace(/(\r\n|\n|\r)/gm, "");
    var hta = document.getElementById('personal_message_body').value = newtxt;
}); 
