$(function(){

  $('#addComment').on('submit', function(event){
    event.preventDefault();
    var new_comment = {};
    new_comment.post_id  = this.dataset.id;
    new_comment.body = $('#new_comment').val();
    console.log(new_comment);
    var _this = this;
    $.ajax({
      typ: 'post',
      url: 'posts/'+new_comment.post_id+'/comments.json',
      data: {comment: new_comment}
    }).done(function(data){
      console.log('comment added!');
    });
  });






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

