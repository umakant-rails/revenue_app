import $ from 'jquery';

$(document).ready(function(){
  var selectedFileArr = []
  $("#dropFiles").on('dragenter', function(ev) {
      // Entering drop area. Highlight area
      $("#dropFiles").addClass("highlightDropArea");
  });
  
  $("#dropFiles").on('dragleave', function(ev) {
    // Going out of drop area. Remove Highlight
    $("#dropFiles").removeClass("highlightDropArea");
  });
  
  $("#dropFiles").on('drop', function(ev) {
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
          $("#imageToPdf").prop("files", droppedFiles);
        }
      }
    }

    $("#dropFiles").removeClass("highlightDropArea");
    return false;
  });
  
  $("#dropFiles").on('dragover', function(ev) {
      ev.preventDefault();
  });

  $("#imageToPdf").on('change', function(e){
    var files = e.target.files;
    for(var i = 0; i < files.length; i++) {
      getImgData(files[i])
    }
  });

  $(document).on('click', ".open-file-dialog, #open-file-dialog-div", function(){
    $("#imageToPdf").click();
  });

  $(document).on('click', ".remove-selected-image", function(){
    $(".file-checkbox").each(function() {
      if ($(this).is(":checked")) {
        $(this).parent().remove();
      }
    });
  });

  function getImgData(files) {
    if(selectedFileArr.indexOf(files.name) == -1){
      selectedFileArr.push(files.name);
    } else {
      alert('This file is already selected.');
      return;
    }

    const fileReader = new FileReader();
    fileReader.readAsDataURL(files);

    fileReader.addEventListener("load", function () {
      var imageStr = `<div class="col-md-2 image-holder">
        <img src="${this.result}" style="width:100%;height:200px" class="ms-2 mb-2"/>
        <input type="checkbox" name="file" class="file-checkbox form-check-input me-1">${files.name}
      </div>`;

      if($("#dropFiles").find(".open-file-dialog").length == 0){
        $("#imageToPdf").hide();
        $("#file-select-bottom-div").show();
        imageStr = imageStr + `<div class="open-file-dialog">
          <i class="fa-solid fa-plus"></i>
        </div>`;
        $("#dropFiles").append(imageStr);
      } else {
        $("#dropFiles").prepend(imageStr);
      }
    }); 
  }

})