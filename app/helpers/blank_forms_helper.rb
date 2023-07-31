module BlankFormsHelper

  def blank_string(length, is_translate=true, class_name='')
    arr = []
    length.times{arr.push("_")}
    str = "<span class='filled-txt #{class_name}' data-blnk-frm-target='textHolder' data-translatable= #{is_translate} data-action='click->blnk-frm#createInput' >"
    str = str + arr.join(" ")
    str = str + "</span>"
    return str
  end

end
