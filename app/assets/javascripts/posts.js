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


  //   updated_todo.completed = checkbox.checked;
    // good.id = this.dataset.id;

  //   // Let's write a update request
  //   $.ajax(
  //     {type: 'patch', url: '/todos/'+updated_todo.id+'.json', data: {todo: updated_todo}
  //   }).done(function(data){
  //       $(_this).toggleClass("done-true");
  //     });
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

