var input_mask =(function(){
   $("#date").inputmask("d/m/y");  //direct mask
   $("#phone").inputmask("mask", {"mask": "(999) 999-9999"}); //specifying fn & options
   $("#tin").inputmask({"mask": "99-9999999"}); //specifying options only
});


$(document).ready(input_mask);
$(document).on('page:load', input_mask);
