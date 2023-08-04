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
  });

  $(".add-row").on('click', function(){

    var trString = `
      <tr>
        <td><span class="applicant" data-blnk-frm-target="textHolder" data-translatable="true" 
          data-action="click->blnk-frm#createInput">_ _ _ _ _ _ _ _ _</span></td>
        <td><span class="registration_number" data-blnk-frm-target="textHolder" data-translatable="false" 
          data-action="click->blnk-frm#createInput">_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _</span></td>
        <td><span class="" data-blnk-frm-target="textHolder" data-translatable="false" 
        data-action="click->blnk-frm#createInput">_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _</span></td>
        <td><span class="" data-blnk-frm-target="textHolder" data-translatable="false" 
        data-action="click->blnk-frm#createInput">_ _ _ _ _</span></td>
      </tr>`;
    $("table#my-data-table tbody").append(trString);
  });
  $(".remove-row").on('click', function(){
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

});