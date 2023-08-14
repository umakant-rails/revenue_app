// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from '@rails/ujs';
import $ from 'jquery';
window.$ = $;

import "bootstrap";
import "popper";
import "controllers";
import "tinymce";
import './formjs-custom';
import './drag-and-drop';
// import "formjs";

$(document).ready(function(){
  tinymce.init({
    selector: '.tinymce',
    height: 330,
    width: '21cm',
    menubar: false,
    indentation : '10pt',
    lineheight: '10pt',
    fontsize_formats: "10px 11px 12px 13px 14px 15px 16px 17px 18px 19px 20px 21px 22px 23px 24px 25px 26px 27px 28px 29px 30px",
    lineheight_formats: "16pt 18pt 20pt 22pt 24pt 26pt 28pt 30pt 32pt 34pt 36pt 38pt 40pt",
    content_style: "p {margin-top: 0px; margin-bottom: 0px;}",
    plugins: [
      'advlist autolink lists link image charmap print preview anchor',
      'searchreplace visualblocks code fullscreen',
      'insertdatetime media table paste code help wordcount'
    ],
    toolbar1: 'undo redo | formatselect | fontsizeselect | lineheight |' +
      ' bold italic backcolor | alignleft aligncenter ' +
      ' alignright alignjustify | bullist numlist outdent indent | ' +
      ' removeformat | help',
    toolbar2: 'table tablecellprops tablecopyrow tablecutrow tabledelete tabledeletecol tabledeleterow tableinsertdialog tableinsertcolafter tableinsertcolbefore tableinsertrowafter tableinsertrowbefore tablemergecells tablepasterowafter tablepasterowbefore tableprops tablerowprops tablesplitcells tableclass tablecellclass tablecellvalign tablecellborderwidth tablecellborderstyle tablecaption tablecellbackgroundcolor tablecellbordercolor tablerowheader tablecolheader',
   });
});

Rails.start();