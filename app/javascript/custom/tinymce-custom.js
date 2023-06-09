$(document).ready(function(){
  tinyMCE.activeEditor.on('change keyup', function(ed, e) {
    var content = tinyMCE.get("order_template_template").getContent();

    $(".order_details").html(content);
  });
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
    control.makeTransliteratable(["order_template_template_ifr"]);
  }
  google.setOnLoadCallback(onLoad);
});