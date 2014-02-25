$(function(){
  //onclick event for a post
  $('.item').on('click','.post', function(event){
  var like = {};
    //sets the good boolean to true or false based on button clicked
    if(event.target.id === "good"){
      like.good = true;
    }
    if(event.target.id === "evil"){
      like.good = false;
    }
    like.likeable_type = "Post";
    like.likeable_id = this.dataset.id;

  var _this = this;
    //making the ajax call to route specified with the post id
    $.ajax({
      type: 'post', 
      url: '/posts/'+like.likeable_id+'/like.json', 
      data: {like: like}
    }).done(function(data){
        //ajax response includes good and evil count
        $(_this).find('.good_post').text(data.good_count);
        $(_this).find('.evil_post').text(data.evil_count);
      });

  });
  //onclick event for a comment
  $('.item').on('click','.comment', function(event){
  var like = {};
    if(event.target.id === "good"){
      like.good = true;
    }
    if(event.target.id === "evil"){
      like.good = false;
    }
    like.likeable_type = "Comment";
    like.likeable_id = this.dataset.id;

  var _this = this;
    //making the ajax call to route specified with the comment id
    $.ajax({
      type: 'post', 
      url: '/comments/'+like.likeable_id+'/like.json', 
      data: {like: like}
    }).done(function(data){
        $(_this).find('.good_comment').text(data.good_count);
        $(_this).find('.evil_comment').text(data.evil_count);
      });

  });



});

//  IMAGE LOAD AND CANVAS DISPLAY // 

$(function(){




    var imageLoader = document.getElementById('imageLoader');
        imageLoader.addEventListener('change', handleImage, false);
    var canvas = document.getElementById('imageCanvas');
    var ctx = canvas.getContext('2d');
      console.log('derpy')
    

    function handleImage(e) {
      console.log('hello')
      var reader = new FileReader();
      reader.onload = function(event){
        var img = new Image();
        img.onload = function(){
            console.log("derp");
          var maxWidth = $('#myModal').width();
          var maxHeight = 600;
          var tempWidth = img.width;
          var tempHeight = img.height;
          if (tempWidth > tempHeight) {
            if (tempWidth > maxWidth) {
              tempHeight *= maxWidth/tempWidth;
              tempWidth = maxWidth;
            }
          } else {
            if (tempHeight > maxHeight) {
              tempWidth *= maxHeight/tempHeight;
              tempHeight = maxHeight;
            }
          }

          canvas.width = img.width;
          canvas.height = img.height;


          ctx.drawImage(this, 0, 0, tempWidth, tempHeight);
        };
        img.src = event.target.result;
      };
      reader.readAsDataURL(e.target.files[0]);
    }


  $(window).bind('resize', function(){
    var newWidth = $('#myModal').width();
    document.getElementById('imageCanvas').style.width = newWidth + "px";
    // console.log($('#myModal').width());

    // select img tags and set width to $('#myModal').width()
  });

});










