import $ from 'jquery';

$(document).ready(function(){

  $(".print-btn").on('click', function(){
    var restorePage = $('body').html();
    var printContent = '';

    if($('.only-print:visible').hasClass("page-a4")){
      printContent = $('.only-print').removeClass("page-a4").addClass("page").not(':hidden').clone();
    } else {
      printContent = $('.only-print').removeClass("page-a4-landscape").addClass("page-landscape").not(':hidden').clone();
    }

    $('body').empty().html(printContent);
    window.print();
    $('body').html(restorePage);
  });

  $(".set-pmkisan-data").on("change", function(){  
    var district = $("#district").val();
    var tehsil = $("#tehsil").val();
    var circle = $("#circle").val();
    var village = $("#request_village_id").find(':selected').text();
    var halka_name = $("#request_village_id").find(':selected').attr('halka_name');
    var halka_number = $("#request_village_id").find(':selected').attr('halka_number');

    $(".tehsil").attr({'data-is-read': true, 'data-blank-text': $(".tehsil").text()}).text(tehsil);
    $(".halka_number").attr({'data-is-read': true, 'data-blank-text': $(".halka_number").text()}).text(halka_number);
    $(".halka_name").attr({'data-is-read': true, 'data-blank-text': $(".halka_name").text()}).text(halka_name);
    $(".village").attr({'data-is-read': true, 'data-blank-text': $(".village").text()}).text(village);

    if($(".patwari-letter").is(':visible')){
      var karyalayStatus = "कार्यालय पटवारी हल्का नंबर " + halka_number + ", तहसील " + tehsil;
      var addressing_office = "<div>तहसीलदार महोदय,</div><div>तहसील " + tehsil + ", जिला " + district;
      var signStatus = "<div>पटवारी</div><div> हल्का नंबर "+halka_number+"</div>"
      $(".karyalay-status").text(karyalayStatus);
      $(".addressing-office").html(addressing_office);
      $(".sign-status").html(signStatus);
    } else if($(".tehsildar-letter").is(':visible')){
      $("#district-status").text(district);
      var karyalayStatus = "कार्यालय तहसीलदार " + tehsil + ", तहसील " + tehsil;
      var signStatus = "<div>तहसीलदार</div><div>"+tehsil+"</div>"
      $("#karyalay-status").text(karyalayStatus);
      $(".sign-status").html(signStatus);
    }
   
  });

  $("#karyalay-select-box").on("change", function(){
    var tehsil = $("#tehsil").val();
    var circle = $("#circle").val();
    var village = $("#request_village_id").val();
    var karyalay = $(this).val();
    var karyalayStatus = '';
    var signStatus = '';

    // if(village.length == 0){
    //   alert(" कृपया पहले ग्राम चुने.");
    //   return;
    // }

    // if(karyalay == 'nayab-tehsildar') {
    //   karyalayStatus = "कार्यालय नायब तहसीलदार " + circle + ", तहसील " + tehsil;
    //   signStatus = "<div>नायब तहसीलदार</div><div> वृत्त-"+circle+", तहसील-"+tehsil+"</div>"
    //   $("#karyalay-status").text(karyalayStatus);
    //   $("#sign-status").html(signStatus);
    // } else {
    //   karyalayStatus = "कार्यालय तहसीलदार " + tehsil + ", तहसील " + tehsil;
    //   signStatus = "<div>तहसीलदार</div><div>"+tehsil+"</div>"
    //   $("#karyalay-status").text(karyalayStatus);
    //   $("#sign-status").html(signStatus);
    // } 
    if(karyalay == 'tehsildar' || karyalay == 'nayab-tehsildar'){
      $('.tehsildar-letter').css('display', 'block');
      $('.patwari-letter').css('display', 'none');
    }  else if (karyalay == 'patwari') {
      $('.patwari-letter').css('display', 'block');
      $('.tehsildar-letter').css('display', 'none');
    }  
  });

  $(".sandarbh-delete").on('click', function(){
    var vl = $(this).parent().text();
    if(vl.indexOf("_ _ _") >= 0){
      $(this).parent().remove();
      $(".subject-status").removeClass("mb-1").addClass("mb-3");
    } else {
      $(this).remove();
    }
  });

});