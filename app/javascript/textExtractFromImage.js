import $ from 'jquery';

var getFileText = function(filePath){
  Tesseract.recognize(
    filePath,
    'hin',
    { logger: m => /*console.log(m)*/$("#extract-data").html('Work is going on....')  }
  ).then(({ data: { text } }) => {
    $("#extract-data").html(text);
  })
}

$(document).ready(function(){
  $(document).on('click', "#read-image", function(){
    var files = $("#file001").prop("files");
    getFileText(files[0]);
  });
  
});