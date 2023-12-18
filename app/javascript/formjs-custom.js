import $ from 'jquery';

var utilFunctions = (function(){
  var printA4Page = function(){
    var restorePage = $('body').html();
    var printContent = '';
    $(".hide-on-print").css('display', 'none')
    if($('.only-print:visible').hasClass("page-a4")){
      printContent = $('.only-print').removeClass("page-a4").addClass("page").not(':hidden').clone();
    } else {
      printContent = $('.only-print').removeClass("page-a4-landscape").addClass("page-landscape").not(':hidden').clone();
    }

    $('body').empty().html(printContent);
    window.print();
    $('body').empty().html(restorePage);
  };

  return {
    printA4Page: printA4Page
  }
})();


var loksewaFunctions = (function () {
  var selectCastCertificate = function(element){
    if($(element).hasClass('obc-form-btn')) {
      $(".obc-element").show();
      $(".scst-element").hide();
      $(".fnt-pink").removeClass("fnt-pink").addClass("fnt-blue");
      $(".bdr-pink-3").removeClass("bdr-pink-3").addClass("bdr-blue-3");
      $(".bdr-pink").removeClass("bdr-pink").addClass("bdr-blue");
      $(".bg-pink").removeClass("bg-pink").addClass("bg-blue");
      bdr-pink
    } else if($(element).hasClass('scst-form-btn')){
      $(".obc-element").hide();
      $(".scst-element").show();
      $(".fnt-blue").removeClass("fnt-blue").addClass("fnt-pink");
      $(".bdr-blue-3").removeClass("bdr-blue-3").addClass("bdr-pink-3");
      $(".bdr-blue").removeClass("bdr-blue").addClass("bdr-pink");
      $(".bg-blue").removeClass("bg-blue").addClass("bg-pink");
    }
  };

  return {
    selectCastCertificate: selectCastCertificate,
  };
})();


$(document).ready(function(){

  $(document).on('click', ".obc-form-btn, .scst-form-btn", function(){
    loksewaFunctions.selectCastCertificate(this);
  });

  $(document).on('click', ".print-btn", function(){
    utilFunctions.printA4Page();
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
  });

  $(document).on('click', ".add-row", function(){
    var rowFormatData = $("#row_format").html();
    var trString = `<tr>${rowFormatData}</tr>`;
    $("table#my-data-table tbody").append(trString);
  });

  $(document).on('click', ".remove-row", function(){
    var $rows = $("table#my-data-table tbody tr");
    if($rows.length == 1){
      alert("डाटा टेबल की अंतिम पक्ति  डिलीट नहीं की जा सकती है | ");
      return;
    }

    if($(this).hasClass('text-danger')){
      $("table tbody").find("tr:last").remove();
    }
    if($(this).hasClass("text-warning")){
      let lineNumber = prompt("डिलीट की जाने वाली लाइन नंबर:");
      if(lineNumber == '' || lineNumber == undefined){
        return;
      }
      $rows[lineNumber-1].remove();
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

  $(".parent-delete").on('click', function(){
    var parentId = $(this).data('parent');
    $("#"+parentId).remove(); 
  });

  $(".toggle-select-box").on('change', function(){
    var targetsToHide = $(this).find(':selected').attr('target-class');
    var targetsToDisplay = $(this).find(':selected').attr('target-id');
    $(targetsToHide).hide();
    $(targetsToDisplay).show();
  });

  $(".add-seemankan-row, .remove-seemankan-row").on('click', function(){
    console.log(this);
    if($(this).hasClass('add-seemankan-row')){
      $("#participants").append(`<div class="seemankan_participant">
        <span class="filled-txt participant_person4" data-blnk-frm-target="textHolder" data-translatable="true" data-action="click->blnk-frm#createInput">_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _</span>
      </div>`);
    } else {
      var total_children = $("#participants").find(".seemankan_participant").length;
      if(total_children > 2){
        $("#participants").find(".seemankan_participant:last").remove();
      } else {
        alert("सीमांकन में दो से कम प्रतिभागी नही हो सकते है।");
      }
    }
  });
});