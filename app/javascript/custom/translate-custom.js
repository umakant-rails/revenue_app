$(document).ready(function(){
  google.load("elements", "1", {
    packages: "transliteration"
  });
  function onLoad() {
    var options = {
        sourceLanguage:
            google.elements.transliteration.LanguageCode.ENGLISH,
        destinationLanguage:
            [google.elements.transliteration.LanguageCode.HINDI],   
        shortcutKey: 'ctrl+g',
        transliterationEnabled: true
    };
    var control =
        new google.elements.transliteration.TransliterationControl(options);
    //control.makeTransliteratable($(".trans_input").map((i, element) => element.id ));
    control.makeTransliteratable(["input1"])
    //control.showControl('input1');
  }
  google.setOnLoadCallback(onLoad);

});