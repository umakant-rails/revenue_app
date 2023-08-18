import $ from 'jquery';

$(document).ready(function(){
  var selectedFileArr = {};
  var fileNumber = undefined;
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
      $("#dropFiles").addClass("highlight-drop-area");
  });
  
  $(document).on('dragleave', ".before-file-container, .file-processing-container", function(ev) {
    // Going out of drop area. Remove Highlight
    $("#dropFiles").removeClass("highlight-drop-area");
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

    $(document).removeClass("highlight-drop-area");
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
        var keys = Object.keys(selectedFileArr).filter(file => file == fileName);
        delete selectedFileArr[keys];
      }
    });
  });

  $(document).on('click', ".open-file-dialog1", function(){
    $("#imageToPdf").click();
  });

  
  $(document).on('click',".convert-image-to-pdf", function(){
    convertImageIntoPdf()
  });

  function convertImageIntoPdf(){
    var formData = new FormData();
    var request = new XMLHttpRequest();

    var authenticity_token = $("#authenticity_token").val();
    formData.set("authenticity_token", authenticity_token);
    Object.entries(selectedFileArr).forEach(([key, vl], ind) => {
      formData.set(`files[${ind}]`, vl);
    });

    request.open("POST", "/pdfs/convert/imagetopdf");
    request.onreadystatechange = function (oEvent) {
      if (request.readyState === 4) {
        if (request.status === 200) {
          console.log(request.response)
          var res = JSON.parse(request.response);
          $("#file-size").html(`Your File Size is : ${res['file_size']}`)
          $(".file-processing-container").hide();
          $(".file-downloading-container").show();
          fileNumber = res['file_number'];
        } else {
          console.log("Error", request.statusText);
        }
     }
    };
    request.send(formData);
  }

  $(document).on('click', '.backward-icon', function(){
    if(fileNumber != undefined){
      var authenticity_token = $("#authenticity_token").val();
      var params = {
        file_number: fileNumber,
        authenticity_token: authenticity_token
      }
      deletePdf(params, 'backward')
    }
  });

  $(document).on('click', '.delete-pdf-icon', function(){
    if(fileNumber != undefined){
      var authenticity_token = $("#authenticity_token").val();
      var params = {
        file_number: fileNumber,
        authenticity_token: authenticity_token
      }
      deletePdf(params, 'delete')
    }
  });

  $(document).on('click', ".file-download-btn", function(){
    window.location = `/pdfs/${fileNumber}/download`;
    window.target = "_blank";
    window.done = 1;
  });
  function getImgData(files) {
    $("#imageToPdf").val("");

    if(Object.keys(selectedFileArr).indexOf(files.name) == -1){
      selectedFileArr[files.name] = files;
    } else {
      alert('This file is already selected.');
      return;
    }
    const fileReader = new FileReader();
    fileReader.readAsDataURL(files);
    // convertImageIntoPdf(files);
    fileReader.addEventListener("load", function () {
      var imageStr = `<div class="col-md-2 image-holder mb-2">
        <img src="${this.result}" style="width:100%;height:200px" class="ms-2 mb-2"/>
        <input type="checkbox" name="file" class="file-checkbox form-check-input me-1" data-vl="${files.name}">${files.name}
      </div>`;

      if($(".file-holding-sub-container").find(".image-holder").length == 0){
        $(".before-file-container").hide();$(".file-processing-container").show();
        $(".file-holding-sub-container").prepend(imageStr);
      } else {
        $(".file-processing-container").find(".image-holder").last().after(imageStr);
      }

    });
  }

  function deletePdf(params, action){
    $.ajax({
      type: 'Delete',
      url: `/pdfs/${params['file_number']}/delete`,
      data: params,
      dataType: 'script',
      success: function(data){
        if(action == "backward") {
          $(".file-downloading-container").hide();
          $(".file-processing-container").show();
        } else if (action == "delete"){
          $(".image-holder").remove();
          $(".file-downloading-container").hide();
          $(".file-processing-container").show();
        }
      }
    });
  }
})