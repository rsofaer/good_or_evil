$(function(){

  $('.item').on('click','.post', function(event){
  console.log(event);
  console.log(event.target);
  if(event.target.id === "good"){
    // var checkbox = event.target;
    var good_btn = event.target;
    var _this = this;

    // var updated_todo = {};
    var good = {good: true, likeable_type:"Post"};
    good.likeable_id = this.dataset.id;

    $.ajax(
      {type: 'post', url: '/posts/'+good.likeable_id+'/like.json', data: {like: good}
    }).done(function(data){

        $(_this).find('.good_post').text(data.good_count);
        $(_this).find('.evil_post').text(data.evil_count);

      });
    }

  });

  $('.item').on('click','.comment', function(event){
  console.log(event);
  console.log(event.target);
  if(event.target.id === "good"){
    // var checkbox = event.target;
    var good_btn = event.target;
    var _this = this;
    console.log(this);
    console.log(this.dataset);
    var good = {};

    }

  });




});

