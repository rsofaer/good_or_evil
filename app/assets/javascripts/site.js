window.onload = function () {

  CanvasJS.addColorSet("goodorevil",
                [
                "#FFF",
                "#000"                
                ]);

// if logic needed here

if ($('#chartContainer_all_votes_all_posts').length === 0) {
  return;
}

  var chart1 = new CanvasJS.Chart("chartContainer_all_votes_all_posts",
    {
      animationEnabled: true, // change to false
      title:{
        fontSize: 20,
        text: "Everyone's votes on everyone's posts"
      },
      backgroundColor: "none",
      colorSet: "goodorevil",
      creditText: "",
      data: [
      {
        type: "doughnut",
       dataPoints: [
        { label: "good", y: gon.all_votes_all_posts_good },
        { label: "evil", y: gon.all_votes_all_posts_evil }
       ]
     }
     ]
   });

    chart1.render();

  var chart2 = new CanvasJS.Chart("chartContainer_your_votes_all_posts",
    {
      animationEnabled: true, // change to false
      title:{
        fontSize: 20,
        text: "Your votes on everyone's posts"
      },
      backgroundColor: "none",
      colorSet: "goodorevil",
      creditText: "",
      data: [
      {
        type: "doughnut",
       dataPoints: [
        { label: "good", y: gon.your_votes_all_posts_good },
        { label: "evil", y: gon.your_votes_all_posts_evil }
       ]
     }
     ]
   });

    chart2.render();

    var chart3 = new CanvasJS.Chart("chartContainer_all_votes_your_posts",
    {
      animationEnabled: true, // change to false
      title:{
        fontSize: 20,
        text: "Everyone's votes on your posts"
      },
      backgroundColor: "none",
      colorSet: "goodorevil",
      creditText: "",
      data: [
      {
        type: "doughnut",
       dataPoints: [
        { label: "good", y: gon.all_votes_your_posts_good },
        { label: "evil", y: gon.all_votes_your_posts_evil }
       ]
     }
     ]
   });

    chart3.render();

    
};