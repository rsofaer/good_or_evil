$(function(){

  CanvasJS.addColorSet("goodorevil",
                [
                "#FFF",
                "#000"                
                ]);
var makeChart = function(index, value){
  
  var chart = new CanvasJS.Chart("chartContainer_"+value.id,
  {
    creditText: "",
    backgroundColor: "none",
    axisX:{
    lineThickness: 0,
    gridThickness: 0,
    valueFormatString: " ",
    tickLength: 0,
    lineColor: "none"
    },
    axisY:{
    lineThickness: 0,
    gridThickness: 0,
    valueFormatString: " ",
    tickLength: 0,
    lineColor: "none"
    },
    colorSet: "goodorevil",
    data:[
    {        
      type: "stackedBar100",
      showInLegend: false, 
      labelFontColor: "none",
      labelFontSize: "none",
      // tickThickness: 0,
      dataPoints: [
      {y: value.good_count },
      ]
    },
    {        
      type: "stackedBar100",
      showInLegend: false, 
      labelFontColor: "none",
      labelFontSize: "none",
      // tickThickness: 0,
      dataPoints: [
      {y: value.evil_count},
      ]
      }       
    ]

  });
  chart.render();

};
// .each is taking gon.posts and calling makeChart
  if(gon.posts !== undefined){
    $.each(gon.posts, makeChart);
 console.log(gon.posts);

}

  $('.addComment').on('submit', function(event){
    event.preventDefault();
    var new_comment = {};
    new_comment.post_id  = this.dataset.id;
    new_comment.body = $('.new_comment_'+this.dataset.id).val();

    var _this = this;
    $.ajax({
      type: 'post',
      url: '/posts/'+new_comment.post_id+'/comments.json',
      data: {comment: new_comment}
    }).done(function(data){
      var commentHTML = HandlebarsTemplates.comment(data);
      $(".comment_container_"+_this.dataset.id).append(commentHTML);
      $('.new_comment_'+_this.dataset.id).val("");
    });
  });


  //onclick event for a post
  $('.item').on('click','.post', function(event){
    event.preventDefault();
    console.log('clicked post');
  var like = {};
    //sets the good boolean to true or false based on button clicked
    if(event.target.id === "good_btn"){
      like.good = true;
    }
    if(event.target.id === "evil_btn"){
      like.good = false;
    }
    like.likeable_type = "Post";
    like.likeable_id = this.dataset.id;
    // console.log(this);
    // console.log(like);
  var _this = this;
    //making the ajax call to route specified with the post id
    $.ajax({
      type: 'post', 
      url: '/posts/'+like.likeable_id+'/like.json', 
      data: {like: like}
    }).done(function(data){
      console.log(data);
        //ajax response includes good and evil count
        $(_this).find('.good_post').text(data.good_count);
        $(_this).find('.evil_post').text(data.evil_count);
        // console.log(data);
        makeChart(0,data);
      });

  });
  //onclick event for a comment
  $('.item').on('click','.comment', function(event){
    event.preventDefault();
    console.log('clicked comment');
  var like_comment = {};
    if(event.target.id === "good_btn"){
      like_comment.good = true;
    }
    if(event.target.id === "evil_btn"){
      like_comment.good = false;
    }
    like_comment.likeable_type = "Comment";
    like_comment.likeable_id = this.dataset.id;
    console.log(like_comment);
  var _this = this;
    //making the ajax call to route specified with the comment id
    $.ajax({
      type: 'post', 
      url: '/posts/'+like_comment.likeable_id+'/like.json', 
      data: {like: like_comment}
    }).done(function(data){
      console.log(data);
        $(_this).find('.good_comment').text(data.good_count);
        $(_this).find('.evil_comment').text(data.evil_count);
      });

  });

});

//  IMAGE LOAD AND CANVAS DISPLAY // 



$(function(){
  if ($('#imageLoader').length === 0){
    return;
  }
  
    var imageLoader = document.getElementById('imageLoader');
        imageLoader.addEventListener('change', handleImage, false);
    var canvas = document.getElementById('imageCanvas');
    var ctx = canvas.getContext('2d');

    function handleImage(e) {
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








