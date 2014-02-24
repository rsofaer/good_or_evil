$(function(){

  $('.item').on('click','.post', function(event){
  console.log(event);
  console.log(event.target);
  if(event.target.id === "good"){
    // var checkbox = event.target;
    var good_btn = event.target;
    var _this = this;
    console.log(this);
    console.log(this.dataset);
    // var updated_todo = {};
    var good = {good: true, likeable_type:"Post"};
    good.likeable_id = this.dataset.id;

    console.log(good);


  //   // Let's write a update request
    $.ajax(
      {type: 'post', url: '/posts/'+good.likeable_id+'.json', data: {good: good}
    }).done(function(data){
        //some function here
        console.log("ajax call done");
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

