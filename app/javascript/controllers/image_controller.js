import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['language', 'selectedFile', 'krutidevBlock', 'unicodeBlock', 'tmpTextArea',
    'selectedImage', 'croppedImages', 'saveBtn', 'downloadBtn'
  ];
  

  connect(){
    this.cropper = '';
  }

  convertToKrutidev(sourceTextElement) {
    //setTimer();

    var array_one = new Array( 
    // ignore all nuktas except in ड़ and ढ़
    "‘","’","“","”","(",")","{","}","=","।","?","-","µ","॰",",",".","् ", 
    "०","१","२","३","४","५","६","७","८","९","x","+",";","_",
    "फ़्","क़","ख़","ग़","ज़्","ज़","ड़","ढ़","फ़","य़","ऱ","ऩ",    // one-byte nukta varNas
    "त्त्","त्त","क्त","दृ","कृ",
    "श्व","ह्न","ह्य","हृ","ह्म","ह्र","ह्","द्द","क्ष्","क्ष","त्र्","त्र","ज्ञ",
    "छ्य","ट्य","ठ्य","ड्य","ढ्य","द्य","द्व",
    "श्र","ट्र","ड्र","ढ्र","छ्र","क्र","फ्र","द्र","प्र","ग्र","रु","रू",
    "्र",
    "ओ","औ","आ","अ","ई","इ","उ","ऊ","ऐ","ए","ऋ",
    "क्","क","क्क","ख्","ख","ग्","ग","घ्","घ","ङ",
    "चै","च्","च","छ","ज्","ज","झ्","झ","ञ",
    "ट्ट","ट्ठ","ट","ठ","ड्ड","ड्ढ","ड","ढ","ण्","ण",  
    "त्","त","थ्","थ","द्ध","द","ध्","ध","न्","न",  
    "प्","प","फ्","फ","ब्","ब","भ्","भ","म्","म",
    "य्","य","र","ल्","ल","ळ","व्","व", 
    "श्", "श",  "ष्", "ष",  "स्",   "स",   "ह",     
    "ऑ","ॉ","ो","ौ","ा","ी","ु","ू","ृ","े","ै",
    "ं","ँ","ः","ॅ","ऽ","् ","्","़","/")

    var array_two = new Array( 
    "^","*","Þ","ß","¼","½","¿","À","¾","A","\\","&","&","Œ","]","-","~ ", 
    "å","ƒ","„","…","†","‡","ˆ","‰","Š","‹","Û","$","(","&",
    // "¶","d","[k","x","T","t","M+","<+","Q",";","j","u",
    "¶+","d+","[k+","x+","T+","t+","M+","<+","Q+",";+","j+","u+",
    "Ù","Ùk","ä","–","—",       
    "Üo","à","á","â","ã","ºz","º","í","{","{k","«","=","K", 
    "Nî","Vî","Bî","Mî","<î","|","}",
    "J","Vª","Mª","<ªª","Nª","Ø","Ý","æ","ç","xz","#",":",
    "z",
    "vks","vkS","vk","v","bZ","b","m","Å",",s",",","_",
    "D","d","ô","[","[k","X","x","?","?k","³", 
    "pkS","P","p","N","T","t","÷",">","¥",
    "ê","ë","V","B","ì","ï","M","<",".",".k",   
    "R","r","F","Fk",")","n","è","èk","U","u",   
    "I","i","¶","Q","C","c","H","Hk","E","e",
    "¸",";","j","Y","y","G","O","o",
    "'","'k","\"","\"k","L","l","g",      
    "v‚","‚","ks","kS","k","h","q","w","`","s","S",
    "a","¡","%","W","·","~ ","~","+","@")   // "~j"

    var array_one_length = array_one.length ;
    // var modified_substring = document.getElementById("unicode_text").value  ;
    // var text_size = document.getElementById("unicode_text").value.length ;
    var modified_substring = sourceTextElement  ;
    var text_size = sourceTextElement.length ;
    var processed_text = '' ;  //blank
    var sthiti1 = 0 ;  var sthiti2 = 0 ;  var chale_chalo = 1 ;
    var max_text_size = 6000;

    while ( chale_chalo == 1 ){
      sthiti1 = sthiti2 ;

      if ( sthiti2 < ( text_size - max_text_size ) ){ 
        sthiti2 +=  max_text_size ;
        // while (document.getElementById("unicode_text").value.charAt ( sthiti2 ) != ' ') {sthiti2--;}
        while (sourceTextElement.charAt ( sthiti2 ) != ' ') {sthiti2--;}
      }else {
        sthiti2 = text_size  ;  chale_chalo = 0;
      }
      //var modified_substring = document.getElementById("unicode_text").value.substring ( sthiti1, sthiti2 ) ;
      var modified_substring = sourceTextElement.substring ( sthiti1, sthiti2 ) ;
      Replace_Symbols( ) ;
      processed_text += modified_substring ;
      //document.getElementById("legacy_text").value = processed_text  ;
      //outputTextElement.value = processed_text ;
    }
    return processed_text;
    function Replace_Symbols( ) {
      if (modified_substring != "" ){

        modified_substring = modified_substring.replace ( /त्र्य/g , "«य" )  ; 
        modified_substring = modified_substring.replace ( /श्र्य/g , "Ü‍‍zय" )  ; 
        modified_substring = modified_substring.replace ( /क़/ , "क़" )  ; 
        modified_substring = modified_substring.replace ( /ख़‌/g , "ख़" )  ;
        modified_substring = modified_substring.replace ( /ग़/g , "ग़" )  ;
        modified_substring = modified_substring.replace ( /ज़/g , "ज़" )  ;
        modified_substring = modified_substring.replace ( /ड़/g , "ड़" )  ;
        modified_substring = modified_substring.replace ( /ढ़/g , "ढ़" )  ;
        modified_substring = modified_substring.replace ( /ऩ/g , "ऩ" )  ;
        modified_substring = modified_substring.replace ( /फ़/g , "फ़" )  ;
        modified_substring = modified_substring.replace ( /य़/g , "य़" )  ;
        modified_substring = modified_substring.replace ( /ऱ/g , "ऱ" )  ;

        // code for replacing "ि" (chhotee ee kii maatraa) with "f"  and correcting its position too.
        var position_of_f = modified_substring.indexOf( "ि" )  ;
        while ( position_of_f != -1 ){
          var character_left_to_f = modified_substring.charAt( position_of_f - 1 )  ;
          modified_substring = modified_substring.replace( character_left_to_f + "ि" ,  "f" + character_left_to_f )  ;

          position_of_f = position_of_f - 1  ;

          while (( modified_substring.charAt( position_of_f - 1 ) == "्" )  &  ( position_of_f != 0  ) ){
            var string_to_be_replaced = modified_substring.charAt( position_of_f - 2 ) + "्"  ;
            modified_substring = modified_substring.replace( string_to_be_replaced + "f", "f" + string_to_be_replaced ) ;
            position_of_f = position_of_f - 2  ;
          }
          position_of_f = modified_substring.search( /ि/ , position_of_f + 1 );
        }

        var set_of_matras = "ािीुूृेैोौं:ँॅ" 
        modified_substring += '  '    ; 
        var position_of_half_R = modified_substring.indexOf( "र्" ) ;
        while ( position_of_half_R > 0  ){
          var probable_position_of_Z = position_of_half_R + 2   ;  
          var character_at_probable_position_of_Z = modified_substring.charAt( probable_position_of_Z )

          while( set_of_matras.match( character_at_probable_position_of_Z ) != null ) {
            probable_position_of_Z = probable_position_of_Z + 1 ;
            character_at_probable_position_of_Z = modified_substring.charAt( probable_position_of_Z ) ;
          }

          var right_to_position_of_Z = probable_position_of_Z + 1 ;

          if (right_to_position_of_Z > 0) { 
            var character_right_to_position_of_Z = modified_substring.charAt( right_to_position_of_Z )
            while ( character_right_to_position_of_Z == "्" ) {  
               probable_position_of_Z = right_to_position_of_Z + 1 ;
               character_at_probable_position_of_Z = modified_substring.charAt( probable_position_of_Z ) ; 
               right_to_position_of_Z = probable_position_of_Z + 1 ;
               character_right_to_position_of_Z = modified_substring.charAt( right_to_position_of_Z )
            }
          }
          string_to_be_replaced = modified_substring.substr ( position_of_half_R + 2,(probable_position_of_Z - position_of_half_R)-1) ;
          modified_substring = modified_substring.replace( "र्" + string_to_be_replaced, string_to_be_replaced + "Z" ) ;
          position_of_half_R = modified_substring.indexOf( "र्" ) ;
        }

        modified_substring = modified_substring.substr ( 0 , modified_substring.length - 2 )  ;

        for(var input_symbol_idx = 0; input_symbol_idx < array_one_length; input_symbol_idx++ ){
          var idx = 0  ;  // index of the symbol being searched for replacement
          while (idx != -1 ){
            modified_substring = modified_substring.replace( array_one[ input_symbol_idx ] , array_two[input_symbol_idx] )
            idx = modified_substring.indexOf( array_one[input_symbol_idx] )
          }
        }
      }
      modified_substring = modified_substring.replace( /Zksa/g , "ksZa" ) ; 
      modified_substring = modified_substring.replace( /~ Z/g , "Z~" ) ; 
      modified_substring = modified_substring.replace( /Zk/g , "kZ" ) ; 
      modified_substring = modified_substring.replace( /Zh/g , "Ê" ) ; 
    } // end of the function  Replace_Symbols( )
  }

  getFileText(filePath, language){
    Tesseract.recognize(
      filePath,
      language,
      { logger: (m) => {
          console.log(m);
          this.unicodeBlockTarget.innerHTML = 'Work is going on....';
          this.krutidevBlockTarget.innerHTML = 'Work is going on....';
        }
      }
    ).then(({ data: { text } }) => {
      //$("#unicode-block").html(text);
      this.unicodeBlockTarget.innerHTML = text;
      var krutidevText = this.convertToKrutidev(text);
      //$("#krutidev-block").text(krutidevText);
      this.krutidevBlockTarget.innerHTML = krutidevText;
      $(".read-image").attr('disabled', false);
    }).catch((err) => {
      // $("#unicode-block").html(err);
      // $("#krutidev-block").html(err);
      this.unicodeBlockTarget.innerHTML = err;
      this.krutidevBlockTarget.innerHTML = err;
      $(".read-image").attr('disabled', false);
    });
  }

  readTextFromImage(){
    var language = this.languageTarget.value;
    var files = this.selectedFileTarget.files;

     if(language.length != 0){
      $(".read-image").attr('disabled', true);
      this.getFileText(files[0], language);
    } else {
      alert("Please Select the language.")
    }
  }

  copyToText(event){
    var targetType = event.target.dataset.target;
    var target = '';

    if(targetType == 'unicode-block'){
      target = this.unicodeBlockTarget;
    } else {
      target = this.krutidevBlockTarget;
    }

    this.tmpTextAreaTarget.style.display = "block";
    this.tmpTextAreaTarget.value = target.textContent.trim();
    this.tmpTextAreaTarget.select();
    this.tmpTextAreaTarget.setSelectionRange(0, 99999);
    document.execCommand("copy");
    this.tmpTextAreaTarget.style.display = "none";
  }

  selectToImage(event){
    if (event.target.files.length) {
      const reader = new FileReader();

      reader.onload = (e) => {
        if (e.target.result) {

          let img = document.createElement('img');
          img.id = 'image';
          img.src = e.target.result;

          this.selectedImageTarget.innerHTML = '';
          this.selectedImageTarget.appendChild(img);
          this.selectedImageTarget.classList.remove('hide');
          this.saveBtnTarget.classList.remove('hide');

          this.cropper = new Cropper(img);
        }
      };
      reader.readAsDataURL(event.target.files[0]);
    }
  }

  cropToImage(e){
    e.preventDefault();
    let imgSrc = this.cropper.getCroppedCanvas({
      width:  1200// input value
    }).toDataURL();

    let dtStr = new Date().getTime();

    let img = `
      <div class="col-md-3 mb-3" id="img-${dtStr}">
        <img src="${imgSrc}" class="mb-3" width="100%" height="100%"/>
        <a href="${imgSrc}" class="btn btn-primary download" download="image_${dtStr}"
          data-image-target="downloadBtn">Download</a>
        <a href="javascript:void(0);" data-action="click->image#removeImage"
          class="btn btn-danger" data-parent-id="img-${dtStr}">Remove</a>
      </div>
    `;
    this.croppedImagesTarget.innerHTML += img;
  }

  removeImage(event){
    var parentId = event.target.dataset.parentId;
    $("#"+parentId).remove();
  }

}



/*
let result = document.querySelector('.result'),
img_result = document.querySelector('.img-result'),
img_w = document.querySelector('.img-w'),
img_h = document.querySelector('.img-h'),
options = document.querySelector('.options'),
save = document.querySelector('.save'),
cropped = document.querySelector('.cropped'),
dwn = document.querySelector('.download'),
upload = document.querySelector('#file-input'),
cropper = '';

// on change show image with crop options
upload.addEventListener('change', e => {
  if (e.target.files.length) {
    // start file reader
    const reader = new FileReader();
    reader.onload = e => {
      if (e.target.result) {
        // create new image
        let img = document.createElement('img');
        img.id = 'image';
        img.src = e.target.result;
        // clean result before
        result.innerHTML = '';
        // append new image
        result.appendChild(img);
        // show save btn and options
        save.classList.remove('hide');
        options.classList.remove('hide');
        // init cropper
        cropper = new Cropper(img);
      }
    };
    reader.readAsDataURL(e.target.files[0]);
  }
});

// save on click
save.addEventListener('click', e => {
  e.preventDefault();
  // get result to data uri
  let imgSrc = cropper.getCroppedCanvas({
    width: img_w.value // input value
  }).toDataURL();
  // remove hide class of img
  cropped.classList.remove('hide');
  img_result.classList.remove('hide');
  // show image cropped
  cropped.src = imgSrc;
  dwn.classList.remove('hide');
  dwn.download = 'imagename.png';
  dwn.setAttribute('href', imgSrc);
});

*/