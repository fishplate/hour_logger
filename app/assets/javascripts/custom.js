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

$(document).ready(function(){
   $(window).resize(function() {
      if ($(window).width() <= 980) {
         $('#pending').text('Pending');
      }
      else {
        $('#pending').text('Pending Approval');
      }
   });
});