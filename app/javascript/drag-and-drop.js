import $ from 'jquery';

$(document).ready(function(){
  var selectedFileArr = [];
  // $("#dropFiles").on('dragenter', function(ev) {
  //     // Entering drop area. Highlight area
  //     $("#dropFiles").addClass("highlightDropArea");
  // });
  
  // $("#dropFiles").on('dragleave', function(ev) {
  //   // Going out of drop area. Remove Highlight
  //   $("#dropFiles").removeClass("highlightDropArea");
  // });
  
  // $("#dropFiles").on('drop', function(ev) {
  //   // Dropping files
  //   ev.preventDefault();
  //   ev.stopPropagation();
  //   // Clear previous messages
  //   $("#messages").empty();
  //   if(ev.originalEvent.dataTransfer){
  //     if(ev.originalEvent.dataTransfer.files.length) {
  //       var droppedFiles = ev.originalEvent.dataTransfer.files;
  //       for(var i = 0; i < droppedFiles.length; i++) {
  //         getImgData(droppedFiles[i]);
  //         // $("#imageToPdf").prop("files", droppedFiles);
  //       }
  //     }
  //   }

  //   $("#dropFiles").removeClass("highlightDropArea");
  //   return false;
  // });
  
  // $("#dropFiles").on('dragover', function(ev) {
  //     ev.preventDefault();
  // });

  $(document).on('dragenter', ".before-file-container, .file-processing-container", function(ev) {
      // Entering drop area. Highlight area
      $("#dropFiles").addClass("highlightDropArea");
  });
  
  $(document).on('dragleave', ".before-file-container, .file-processing-container", function(ev) {
    // Going out of drop area. Remove Highlight
    $("#dropFiles").removeClass("highlightDropArea");
  });
  
  $(document).on('drop', ".before-file-container, .file-processing-container", function(ev) {
    // Dropping files
    ev.preventDefault();
    ev.stopPropagation();
    // Clear previous messages
    $("#messages").empty();
    if(ev.originalEvent.dataTransfer){
      if(ev.originalEvent.dataTransfer.files.length) {
        var droppedFiles = ev.originalEvent.dataTransfer.files;
        for(var i = 0; i < droppedFiles.length; i++) {
          getImgData(droppedFiles[i]);
          // $("#imageToPdf").prop("files", droppedFiles);
        }
      }
    }

    $(document).removeClass("highlightDropArea");
    return false;
  });
  
  $(document).on('dragover', ".before-file-container, .file-processing-container", function(ev) {
      ev.preventDefault();
  });

  $("#imageToPdf").on('change', function(e){
    var files = e.target.files;
    for(var i = 0; i < files.length; i++) {
      getImgData(files[i])
    }
  });

  $(document).on('click', ".remove-selected-image", function(){
    $(".file-checkbox").each(function() {
      if ($(this).is(":checked")) {
        $(this).parent().remove();
        var fileName = $(this).parent().text().trim();
        selectedFileArr = selectedFileArr.filter(file=> file != fileName)
      }
    });
  });

  $(document).on('click', ".open-file-dialog1, .open-file-dialog", function(){
    $("#imageToPdf").click();
  });

  function getImgData(files) {
    $("#imageToPdf").val("");

    if(selectedFileArr.indexOf(files.name) == -1){
      selectedFileArr[selectedFileArr.length] = files.name;
    } else {
      alert('This file is already selected.');
      return;
    }
    //console.log(selectedFileArr)
    const fileReader = new FileReader();
    fileReader.readAsDataURL(files);

    fileReader.addEventListener("load", function () {
      var imageStr = `<div class="col-md-2 image-holder">
        <img src="${this.result}" style="width:100%;height:200px" class="ms-2 mb-2"/>
        <input type="checkbox" name="file" class="file-checkbox form-check-input me-1" data-vl="${files.name}">${files.name}
      </div>`;

      if($(".file-processing-container").find(".image-holder").length == 0){
        $(".before-file-container").hide();$(".file-processing-container").show();
        $("#file-select-bottom-div").show();
        $(".file-processing-container").prepend(imageStr);
      } else {
        $(".file-processing-container").find(".image-holder").last().after(imageStr);
      }
    });

  }

})