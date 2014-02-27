$(function(){

  CanvasJS.addColorSet("goodorevil",
                [
                "grey",
                "#000000"                
                ]);
var makeChart = function(index, value){
  
  var chart = new CanvasJS.Chart("chartContainer_"+value.id,
  {
    title:{          
    },
    creditText: "",
    backgroundColor: "none",
    axisX:{
    lineThickness: 0,
    gridThickness: 0,
    lineColor: "none"
    },
    axisY:{
    lineThickness: 0,
    gridThickness: 0,
    lineColor: "none"
    },
    colorSet: "goodorevil",
    data:[
    {        
      type: "stackedBar100",
      showInLegend: false, 
      labelFontColor: "none",
      labelFontSize: "none",
      tickThickness: 0,
      dataPoints: [
      {y: value.good, label: "Good" },
      ]
    },
    {        
      type: "stackedBar100",
      showInLegend: false, 
      labelFontColor: "none",
      labelFontSize: "none",
      tickThickness: 0,
      dataPoints: [
      {y: value.evil, label: "EVIL" },
      ]
    }       
    ]

  });
  chart.render();

};
// .each is taking gon.posts and calling makeChart
 $.each(gon.posts, makeChart);



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
    });
  });


  //onclick event for a post
  $('.item').on('click','.post', function(event){
    event.preventDefault();
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
    event.preventDefault();
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
      url: '/posts/'+like.likeable_id+'/like.json', 
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










