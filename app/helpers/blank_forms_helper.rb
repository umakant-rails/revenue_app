module BlankFormsHelper

  def blank_string(length)
    arr = []
    length.times{arr.push("_")}

    str = '<span class="filled-txt" data-blnk-frm-target="textHolder" data-action="click->blnk-frm#createInput" >'
    str = str + arr.join(" ")
    str = str + "</span>"
    return str
  end

end
