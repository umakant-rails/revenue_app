import $ from 'jquery';

var kruti_array = new Array("ñ","Q+Z","sas","aa",")Z","ZZ","‘","’","“","”","å",  "ƒ",  "„",   "…",   "†",   "‡",   "ˆ",   "‰",   "Š",   "‹", "¶+",   "d+", "[+k","[+", "x+",  "T+",  "t+", "M+", "<+", "Q+", ";+", "j+", "u+","Ùk", "Ù", "ä", "–", "—","é","™","=kk","f=k",  "à",   "á",    "â",   "ã",   "ºz",  "º",   "í", "{k", "{", "=",  "«", "Nî",   "Vî",    "Bî",   "Mî",   "<î", "|", "K", "}","J",   "Vª",   "Mª",  "<ªª",  "Nª",   "Ø",  "Ý", "nzZ",  "æ", "ç", "Á", "xz", "#", ":", "v‚","vks",  "vkS",  "vk",    "v",  "b±", "Ã",  "bZ",  "b",  "m",  "Å",  ",s",  ",",   "_","ô",  "d", "Dk", "D", "[k", "[", "x","Xk", "X", "Ä", "?k", "?",   "³", "pkS",  "p", "Pk", "P",  "N",  "t", "Tk", "T",  ">", "÷", "¥","ê",  "ë",   "V",  "B",   "ì",   "ï", "M+", "<+", "M",  "<", ".k", ".", "r",  "Rk", "R",   "Fk", "F",  ")", "n", "/k", "èk",  "/", "Ë", "è", "u", "Uk", "U",   "i",  "Ik", "I",   "Q",    "¶",  "c", "Ck",  "C",  "Hk",  "H", "e", "Ek",  "E", ";",  "¸",   "j",    "y", "Yk",  "Y",  "G",  "o", "Ok", "O", "'k", "'",   "\"k",  "\"",  "l", "Lk",  "L",   "g",  "È", "z", "Ì", "Í", "Î",  "Ï",  "Ñ",  "Ò",  "Ó",  "Ô",   "Ö",  "Ø",  "Ù","Ük", "Ü","‚",    "ks",   "kS",   "k",  "h",    "q",   "w",   "`",    "s",    "S", "a",    "¡",    "%",     "W",  "•", "·", "∙", "·", "~j",  "~", "\\","+"," ः","^", "*",  "Þ", "ß", "(", "¼", "½", "¿", "À", "¾", "A", "-", "&", "&", "Œ", "]","~ ","@");
var unicode_array = new Array("॰","QZ+","sa","a","र्द्ध","Z","\"","\"","'","'", "०",  "१",  "२",  "३",     "४",   "५",  "६",   "७",   "८",   "९",  "फ़्",  "क़",  "ख़", "ख़्",  "ग़", "ज़्", "ज़",  "ड़",  "ढ़",   "फ़",  "य़",  "ऱ",  "ऩ",  "त्त", "त्त्", "क्त",  "दृ",  "कृ","न्न","न्न्","=k","f=", "ह्न",  "ह्य",  "हृ",  "ह्म",  "ह्र",  "ह्",   "द्द",  "क्ष", "क्ष्", "त्र", "त्र्",  "छ्य",  "ट्य",  "ठ्य",  "ड्य",  "ढ्य", "द्य", "ज्ञ", "द्व", "श्र",  "ट्र",    "ड्र",    "ढ्र",    "छ्र",   "क्र",  "फ्र", "र्द्र",  "द्र",   "प्र", "प्र",  "ग्र", "रु",  "रू", "ऑ",   "ओ",  "औ",  "आ",   "अ", "ईं", "ई",  "ई",   "इ",  "उ",   "ऊ",  "ऐ",  "ए", "ऋ", "क्क", "क", "क", "क्", "ख", "ख्", "ग", "ग", "ग्", "घ", "घ", "घ्", "ङ", "चै",  "च", "च", "च्", "छ", "ज", "ज", "ज्",  "झ",  "झ्", "ञ", "ट्ट",   "ट्ठ",   "ट",   "ठ",   "ड्ड",   "ड्ढ",  "ड़", "ढ़", "ड",   "ढ", "ण", "ण्", "त", "त", "त्", "थ", "थ्",  "द्ध",  "द", "ध", "ध", "ध्", "ध्", "ध्", "न", "न", "न्",    "प", "प", "प्",  "फ", "फ्",  "ब", "ब", "ब्",  "भ", "भ्",  "म",  "म", "म्", "य", "य्",  "र", "ल", "ल", "ल्",  "ळ",  "व", "व", "व्", "श", "श्",  "ष", "ष्", "स", "स", "स्", "ह", "ीं", "्र", "द्द", "ट्ट","ट्ठ","ड्ड","कृ","भ","्य","ड्ढ","झ्","क्र","त्त्","श","श्","ॉ",  "ो",   "ौ",   "ा",   "ी",   "ु",   "ू",   "ृ",   "े",   "ै", "ं",   "ँ",   "ः",   "ॅ",  "ऽ", "ऽ", "ऽ", "ऽ", "्र",  "्", "?", "़",":", "‘",   "’",   "“",   "”",  ";",  "(",    ")",   "{",    "}",   "=", "।", ".", "-",  "µ", "॰", ",","् ","/");
var matraslist = "अ आ इ ई उ ऊ ए ऐ ओ औ ा ि ी ु ू ृ े ै ो ौ ं : ँ ॅ" ;
//var array_from = unicode_array, array_to = kruti_array;
var array_from = new Array( 
"‘",   "’",   "“",   "”",   "(",    ")",   "{",    "}",   "=", "।",  "?",  "-",  "µ", "॰", ",", ".", "् ", "०",  "१",  "२",  "३",     "४",   "५",  "६",   "७",   "८",   "९", "x", "फ़्",  "क़",  "ख़",  "ग़", "ज़्", "ज़",  "ड़",  "ढ़",   "फ़",  "य़",  "ऱ",  "ऩ", "त्त्",   "त्त",     "क्त",  "दृ",  "कृ", "ह्न",  "ह्य",  "हृ",  "ह्म",  "ह्र",  "ह्",   "द्द",  "क्ष्", "क्ष", "त्र्", "त्र","ज्ञ","छ्य",  "ट्य",  "ठ्य",  "ड्य",  "ढ्य", "द्य","द्व", "श्र",  "ट्र",    "ड्र",    "ढ्र",    "छ्र",   "क्र",  "फ्र",  "द्र",   "प्र",   "ग्र", "रु",  "रू","्र", "ओ",  "औ",  "आ",   "अ",   "ई",   "इ",  "उ",   "ऊ",  "ऐ",  "ए", "ऋ", "क्",  "क",  "क्क",  "ख्",   "ख",    "ग्",   "ग",  "घ्",  "घ","ङ", "चै",   "च्",   "च",   "छ",  "ज्", "ज",   "झ्",  "झ",   "ञ", "ट्ट",   "ट्ठ",   "ट",   "ठ",   "ड्ड",   "ड्ढ",  "ड",   "ढ",  "ण्", "ण",  "त्",  "त",  "थ्", "थ",  "द्ध",  "द", "ध्", "ध",  "न्",  "न",  "प्",  "प",  "फ्", "फ",  "ब्",  "ब", "भ्",  "भ",  "म्",  "म", "य्",  "य",  "र",  "ल्", "ल",  "ळ",  "व्",  "व", "श्", "श",  "ष्", "ष",  "स्",   "स",   "ह", "ऑ",   "ॉ",  "ो",   "ौ",   "ा",   "ी",   "ु",   "ू",   "ृ",   "े",   "ै","ं",   "ँ",   "ः",   "ॅ",    "ऽ",  "् ", "्" )
var array_to = new Array( 
"^", "*",  "Þ", "ß", "¼", "½", "¿", "À", "¾", "A", "\\", "&", "&", "Œ", "]","-","~ ", "å",  "ƒ",  "„",   "…",   "†",   "‡",   "ˆ",   "‰",   "Š",   "‹","Û","¶",   "d",    "[k",  "x",  "T",  "t",   "M+", "<+", "Q",  ";",    "j",   "u", "Ù",   "Ùk",   "ä",    "–",   "—", "à",   "á",    "â",   "ã",   "ºz",  "º",   "í", "{", "{k",  "«", "=","K", "Nî",   "Vî",    "Bî",   "Mî",   "<î", "|","}","J",   "Vª",   "Mª",  "<ªª",  "Nª",   "Ø",  "Ý",   "æ", "ç", "xz", "#", ":","z", "vks",  "vkS",  "vk",    "v",   "bZ",  "b",  "m",  "Å",  ",s",  ",",   "_", "D",  "d",    "ô",     "[",     "[k",    "X",   "x",  "?",    "?k",   "³", "pkS",  "P",    "p",  "N",   "T",    "t",   "÷",  ">",   "¥", "ê",      "ë",      "V",  "B",   "ì",       "ï",     "M",  "<",  ".", ".k", "R",  "r",   "F", "Fk",  ")",    "n", "/",  "/k",  "U", "u",  "I",  "i",   "¶", "Q",   "C",  "c",  "H",  "Hk", "E",   "e", "¸",   ";",    "j",  "Y",   "y",  "G",  "O",  "o","'", "'k",  "\"", "\"k", "L",   "l",   "g",  "v‚",    "‚",    "ks",   "kS",   "k",     "h",    "q",   "w",   "`",    "s",    "S", "a",    "¡",    "%",     "W",   "·",   "~ ", "~")   // "~j"


var krutoToMangalFunctions = (function(){
  
  var replsymKrutiToMangal = function(kruti_text, kruti_array_length){

    if ( kruti_text != "" ) {
      for (var input_symbol_idx=0; input_symbol_idx<kruti_array_length; input_symbol_idx++){
        var idx = 0;
        while (idx != -1 ) {
          kruti_text = kruti_text.replace( kruti_array[ input_symbol_idx ] , unicode_array[input_symbol_idx] )
          idx = kruti_text.indexOf( kruti_array[input_symbol_idx] )
        } 
      } 
    }

    kruti_text = kruti_text.replace( /±/g , "Zं" ) ;
    kruti_text = kruti_text.replace( /Æ/g , "र्f" ) ;  
    var pi = kruti_text.indexOf( "f" )

    while ( pi != -1 ){
      var cni = kruti_text.charAt( pi + 1 )
      var ctbr = "f" + cni
      kruti_text = kruti_text.replace( ctbr , cni + "ि" ) 
      pi = kruti_text.search( /f/ , pi + 1 ) 
    } 

    kruti_text = kruti_text.replace( /Ç/g , "fa" ) ; 
    kruti_text = kruti_text.replace( /É/g , "र्fa" ) ;
    var pi = kruti_text.indexOf( "fa" )

    while ( pi != -1 ) {
      var cntip2 = kruti_text.charAt( pi + 2 )
      var ctbr = "fa" + cntip2
      kruti_text = kruti_text.replace( ctbr , cntip2 + "िं" ) 
      pi = kruti_text.search( /fa/ , pi + 2 ) 
    } 

    kruti_text = kruti_text.replace( /Ê/g , "ीZ" ) ; 
    var powe = kruti_text.indexOf( "ि्" ) 

    while ( powe != -1 ) {
      var cntwe = kruti_text.charAt( powe + 2 )
      var ctbr = "ि्" + cntwe 
      kruti_text = kruti_text.replace( ctbr , "्" + cntwe + "ि" ) 
      powe = kruti_text.search( /ि्/ , powe + 2 ) 
    } 
    //matraslist = "अ आ इ ई उ ऊ ए ऐ ओ औ ा ि ी ु ू ृ े ै ो ौ ं : ँ ॅ" 
    var rpos = kruti_text.indexOf( "Z" )

    while ( rpos > 0 ){
      pphr = rpos - 1 ;
      var chtr = kruti_text.charAt( pphr )

      while ( matraslist.match( chtr ) != null ) {
        pphr = pphr - 1 ;
        chtr = kruti_text.charAt( pphr ) ;
      } 

      ctbr = kruti_text.substr ( pphr , ( rpos - pphr ) ) ;
      rstr = "र्" + ctbr ; 
      ctbr = ctbr + "Z" ;
      kruti_text = kruti_text.replace( ctbr , rstr ) ;
      rpos = kruti_text.indexOf( "Z" ) ;
    }
    return kruti_text;
  }

  function repsymbMangalToKruti(mss, afl){

    if (mss != "" ) {
      mss = mss.replace ( /क़/ , "क़" )  ; 
      mss = mss.replace ( /ख़‌/g , "ख़" )  ;
      mss = mss.replace ( /ग़/g , "ग़" )  ;
      mss = mss.replace ( /ज़/g , "ज़" )  ;
      mss = mss.replace ( /ड़/g , "ड़" )  ;
      mss = mss.replace ( /ढ़/g , "ढ़" )  ;
      mss = mss.replace ( /ऩ/g , "ऩ" )  ;
      mss = mss.replace ( /फ़/g , "फ़" )  ;
      mss = mss.replace ( /य़/g , "य़" )  ;
      mss = mss.replace ( /ऱ/g , "ऱ" )  ;

      var pof = mss.indexOf( "ि" )  ;
      while ( pof != -1 ){
        var clf = mss.charAt( pof - 1 )  ;
        mss = mss.replace( clf + "ि" ,  "f" + clf )  ;
        pof = pof - 1  ;

        while (( mss.charAt( pof - 1 ) == "्" )  &  ( pof != 0  ) ) {
          var repl_str = mss.charAt( pof - 2 ) + "्"  ;
          mss = mss.replace( repl_str + "f", "f" + repl_str ) ;
          pof = pof - 2  ;
        }
        pof = mss.search( /ि/ , pof + 1 ) ;
      } 

      var mat = "ािीुूृेैोौं:ँॅ";
      mss += '  '    ;  
      var pohr = mss.indexOf( "र्" ) ;

      while ( pohr > 0  ) {
        var ppoz = pohr + 2   ;  
        var cook = mss.charAt( ppoz + 1 )

        while ( mat.indexOf( cook ) != -1 ) {
          ppoz = ppoz + 1 ;
          cook = mss.charAt( ppoz + 1 ) ;
        } 

        repl_str = mss.substr ( pohr + 2 , ( ppoz - pohr - 1 ))  ;
        mss = mss.replace( "र्" + repl_str  ,  repl_str + "Z" ) ;
        pohr = mss.indexOf( "र्" ) ;
      }

      mss = mss.substr ( 0 , mss.length - 2 )  ;


      for( var idx_sym = 0; idx_sym < afl; idx_sym++ ) {
        var idx = 0  ;  

        while (idx != -1 ) {
          mss = mss.replace( array_from[ idx_sym ] , array_to[idx_sym] )
          idx = mss.indexOf( array_from[idx_sym] )
        } 
      } 
    } 
    return mss;
  }

  var krutiToMangal = function() {
    var text_size = document.getElementById("source-text").value.length ;
    var kruti_array_length = kruti_array.length ;
    var kruti_text = document.getElementById("source-text").value  ;

    var processed_text = '' ;  
    var n = 0 ;  var o = 0 ;  var r = 1 ;
    var max_text_size = 7000;

    while ( r == 1 ) {
      n = o ;

      if ( o < ( text_size - max_text_size ) ) { 
        o +=  max_text_size ;
        while (document.getElementById("source-text").value.charAt ( o ) != ' ') {o--;}
      } else  { 
        o = text_size  ;  r = 0 
      }

      var kruti_text = document.getElementById("source-text").value.substring ( n, o )  ;
      kruti_text = replsymKrutiToMangal(kruti_text, kruti_array_length);
      processed_text += kruti_text ;
      document.getElementById("converted-text").value = processed_text  ;
    }


    // function replsymKrutiToMangal( ) {
    //   if ( kruti_text != "" ) {
    //     for (var input_symbol_idx=0; input_symbol_idx<kruti_array_length; input_symbol_idx++){

    //       var idx = 0  ;  

    //       while (idx != -1 ) {

    //         kruti_text = kruti_text.replace( kruti_array[ input_symbol_idx ] , unicode_array[input_symbol_idx] )
    //         idx = kruti_text.indexOf( kruti_array[input_symbol_idx] )

    //       } 
    //     } 
    //   }

    //   kruti_text = kruti_text.replace( /±/g , "Zं" ) ;
    //   kruti_text = kruti_text.replace( /Æ/g , "र्f" ) ;  
    //   var pi = kruti_text.indexOf( "f" )

    //   while ( pi != -1 ){
    //     var cni = kruti_text.charAt( pi + 1 )
    //     var ctbr = "f" + cni
    //     kruti_text = kruti_text.replace( ctbr , cni + "ि" ) 
    //     pi = kruti_text.search( /f/ , pi + 1 ) 
    //   } 

    //   kruti_text = kruti_text.replace( /Ç/g , "fa" ) ; 
    //   kruti_text = kruti_text.replace( /É/g , "र्fa" ) ;
    //   var pi = kruti_text.indexOf( "fa" )

    //   while ( pi != -1 ) {
    //     var cntip2 = kruti_text.charAt( pi + 2 )
    //     var ctbr = "fa" + cntip2
    //     kruti_text = kruti_text.replace( ctbr , cntip2 + "िं" ) 
    //     pi = kruti_text.search( /fa/ , pi + 2 ) 
    //   } 

    //   kruti_text = kruti_text.replace( /Ê/g , "ीZ" ) ; 
    //   var powe = kruti_text.indexOf( "ि्" ) 

    //   while ( powe != -1 ) {
    //     var cntwe = kruti_text.charAt( powe + 2 )
    //     var ctbr = "ि्" + cntwe 
    //     kruti_text = kruti_text.replace( ctbr , "्" + cntwe + "ि" ) 
    //     powe = kruti_text.search( /ि्/ , powe + 2 ) 
    //   } 
    //   //matraslist = "अ आ इ ई उ ऊ ए ऐ ओ औ ा ि ी ु ू ृ े ै ो ौ ं : ँ ॅ" 
    //   var rpos = kruti_text.indexOf( "Z" )

    //   while ( rpos > 0 ){
    //     pphr = rpos - 1 ;
    //     var chtr = kruti_text.charAt( pphr )

    //     while ( matraslist.match( chtr ) != null ) {
    //       pphr = pphr - 1 ;
    //       chtr = kruti_text.charAt( pphr ) ;
    //     } 

    //     ctbr = kruti_text.substr ( pphr , ( rpos - pphr ) ) ;
    //     rstr = "र्" + ctbr ; 
    //     ctbr = ctbr + "Z" ;
    //     kruti_text = kruti_text.replace( ctbr , rstr ) ;
    //     rpos = kruti_text.indexOf( "Z" ) ;
    //   }
    // }
  }
  
  var mangalToKruti = function(){
    var ts = document.getElementById("source-text").value.length ;
    var afl = array_from.length ;
    var mss = document.getElementById("source-text").value  ;
    var st1 = 0,st2 = 0,looper = 1 ;
    var pt = '' ;  
    var max_ts = 10000;
    while ( looper == 1 ){
      st1 = st2 ;
      if ( st2 < ( ts - max_ts ) ){ 
        st2 +=  max_ts ;
        while (document.getElementById("source-text").value.charAt ( st2 ) != ' ') {st2--;}
      }else { 
        st2 = ts;
        looper = 0; 
      }
      var mss = document.getElementById("source-text").value.substring ( st1, st2 )  ;
      mss = repsymbMangalToKruti(mss, afl) ;
      pt += mss ;
      document.getElementById("converted-text").value = pt  ;
    }
  }

  var copyToClipboard = function () {
    var copyText = document.querySelector("#converted-text");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Mangal Text Copied To Clipboard.");
  }

  var clearText = function(sourceTextElement, convertedTextElement) {
  	sourceTextElement.value = '';
  	convertedTextElement.value = '';
  }
  return {
    krutiToMangal: krutiToMangal,
    mangalToKruti: mangalToKruti,
    copyToClipboard: copyToClipboard,
    clearText: clearText
  }
})();

$(document).ready(function(){
  $(document).on('click', "#convert-kruti-font", function(){
    krutoToMangalFunctions.krutiToMangal();
  });
  $(document).on('click', "#convert-mangal-font", function(){
    krutoToMangalFunctions.mangalToKruti();
  });

  $(document).on('keyup paste change', "#source-text", function(){
    var sourceElementName = document.getElementById("source-text").attributes.name.value;
    if(sourceElementName == "krutitext") {
      krutoToMangalFunctions.krutiToMangal();
    } else {
      krutoToMangalFunctions.mangalToKruti();
    }
  });

  $(document).on('click', "#clear-text", function(){
    var sourceTextElement = document.getElementById("source-text");
    var convertedTextElement = document.getElementById("converted-text");
    krutoToMangalFunctions.clearText(sourceTextElement, convertedTextElement);
  });

  $(document).on('click', "#copy-to-clipboard", function(){
    krutoToMangalFunctions.copyToClipboard();
  });

  $(document).on('click', "#krutidev-font-download, #krutidev-font-chart-download, #inscript-font-chart-download", function(){
     //window.open('/assets/krutidev-010.ttf' , '_blank');
    var id = $(this).attr('id');
    
    if(id == "krutidev-font-download"){
      window.open('/assets/krutidev-010.ttf' , '_blank');
    } else if (id == "krutidev-font-chart-download"){
      //window.open('/assets/krutidev.png' , '_blank');
      window.open('/font_converters/krutidev/image_to_pdf.pdf', '_blank');
    } else if( id == "inscript-font-chart-download"){
      //window.open('/assets/unicode.png' , '_blank')
      window.open('/font_converters/inscript/image_to_pdf.pdf', '_blank')
    }
  });

  //http://localhost:3000/font_converters/assets/krutidev-010.ttf
});