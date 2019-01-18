$(document).ready(function(){
  if($('#movies_body').length){
    $.ajax({
      url: "/movies.js",
      type: "GET"
    })
  }
})
