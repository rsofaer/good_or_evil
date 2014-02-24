$(function(){

  $('.item').on('click','.comments', function(event){
  console.log(event);
  console.log(event.target);
  if(event.target.id === "good"){
    // var checkbox = event.target;
    var good_btn = event.target;
    var _this = this;
    console.log("GOOD!");
    console.log(this);
    // console.log(this.dataset);
    // var updated_todo = {};
    var good = {};
  //   updated_todo.completed = checkbox.checked;
    // updated_todo.id = this.dataset.id;

  //   // Let's write a update request
  //   $.ajax(
  //     {type: 'patch', url: '/todos/'+updated_todo.id+'.json', data: {todo: updated_todo}
  //   }).done(function(data){
  //       $(_this).toggleClass("done-true");
  //     });
    }

  });




});

