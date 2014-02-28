window.onload = function () {

  CanvasJS.addColorSet("goodorevil",
                [
                "#FFF",
                "#000"                
                ]);

// if logic needed here

if ($('#chartContainer_profile').length === 0) {
  return;
}

var chart = new CanvasJS.Chart("chartContainer_profile",
    {
      animationEnabled: true, // change to false
      title:{
        text: "My Good vs Evil Vote"
      },
      backgroundColor: "none",
      colorSet: "goodorevil",
      creditText: "",
      data: [
      {
        type: "doughnut",
       dataPoints: [
        { label: "good", y: gon.good_like_count },
        { label: "evil", y: gon.evil_like_count }
       ]
     }
     ]
   });

    chart.render();

    
};