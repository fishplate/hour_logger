$(document).ready(function(){
  setTimeout(function(){
   $(".alert").fadeOut("slow", function () {
   $(".alert").remove();
  });
  }, 5000);

  $('.datepicker').datepicker({
    format: 'dd-mm-yyyy'
  })

});