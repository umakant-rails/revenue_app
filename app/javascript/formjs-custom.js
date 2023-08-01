import $ from 'jquery';

$(document).ready(function(){

  $(document).on('click', ".print-btn", function(){
    var restorePage = $('body').html();
    var printContent = '';

    if($('.only-print:visible').hasClass("page-a4")){
      printContent = $('.only-print').removeClass("page-a4").addClass("page").not(':hidden').clone();
    } else {
      printContent = $('.only-print').removeClass("page-a4-landscape").addClass("page-landscape").not(':hidden').clone();
    }

    $('body').empty().html(printContent);
    window.print();
    $('body').empty().html(restorePage);
  });

  $(".selection-criteria-box").on("change", function(){
    var targets = $(this).data('target');
    var selectedParameter = $(this).val();

    $(targets).css('display', 'none');
    $("#"+selectedParameter).css('display', 'block'); 
  });

  $(".set-pmkisan-data").on("change", function(){  
    var district = $("#district").val();
    var tehsil = $("#tehsil").val();
    var circle = $("#circle").val();
    var village = $("#request_village_id").find(':selected').text();
    var halka_name = $("#request_village_id").find(':selected').attr('halka_name');
    var halka_number = $("#request_village_id").find(':selected').attr('halka_number');

    $(".district").attr({'data-is-read': true, 'data-blank-text': $(".district").text()}).text(district);
    $(".tehsil").attr({'data-is-read': true, 'data-blank-text': $(".tehsil").text()}).text(tehsil);
    $(".circle").attr({'data-is-read': true, 'data-blank-text': $(".circle").text()}).text(circle);
    $(".halka_number").attr({'data-is-read': true, 'data-blank-text': $(".halka_number").text()}).text(halka_number);
    $(".halka_name").attr({'data-is-read': true, 'data-blank-text': $(".halka_name").text()}).text(halka_name);
    $(".village").attr({'data-is-read': true, 'data-blank-text': $(".village").text()}).text(village);


    // if($(".patwari-letter").is(':visible')){
    //   var karyalayStatus = "कार्यालय पटवारी हल्का नंबर " + halka_number + ", तहसील " + tehsil;
    //   var addressing_office = "<div>तहसीलदार महोदय,</div><div>तहसील " + tehsil + ", जिला " + district;
    //   var signStatus = "<div>पटवारी</div><div> हल्का नंबर "+halka_number+"</div>"
    //   $(".karyalay-status").text(karyalayStatus);
    //   $(".addressing-office").html(addressing_office);
    //   $(".sign-status").html(signStatus);
    // } else if($(".tehsildar-letter").is(':visible')){
    //   $("#district-status").text(district);
    //   var karyalayStatus = "कार्यालय तहसीलदार " + tehsil + ", तहसील " + tehsil;
    //   var signStatus = "<div>तहसीलदार</div><div>"+tehsil+"</div>"
    //   $("#karyalay-status").text(karyalayStatus);
    //   $(".sign-status").html(signStatus);
    // }
   
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