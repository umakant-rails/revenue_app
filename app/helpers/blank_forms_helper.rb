module BlankFormsHelper

  def blank_string(length, is_translate=true, class_name='')
    arr = []
    length.times{arr.push("_")}
    str = "<span class='#{class_name}' data-blnk-frm-target='textHolder' data-translatable= #{is_translate} data-action='click->blnk-frm#createInput' >"
    str = str + arr.join(" ")
    str = str + "</span>"
    return str
  end

  def blank_string_format2(length, is_translate=true, class_name='')
    arr = []
    length.times{arr.push("_")}
    str = "<span class='filled-txt #{class_name}' data-blnk-frm-target='textHolder' data-translatable= #{is_translate} data-action='click->blnk-frm#createInput' >"
    str = str + arr.join(" ")
    str = str + "</span>"
    return str
  end

  def blank_string_text(length)
    arr = []
    length.times{arr.push("_")}
    return arr.join(" ") + ""
  end

  def certificate_name(certificate_name)
    certificate_name.split(" ").collect{|txt| txt.downcase }.join('_')
  end

  def get_current_revenue_year
    date_today = Date.today
    date, month, cur_year = date_today.strftime("%d"), date_today.strftime("%m"), date_today.strftime("%Y")
    last_date_of_rev_year = Date.parse("31/03/#{cur_year}")
    cur_year_short = date_today.strftime("%y")
    current_rev_year = ""

    if date_today < last_date_of_rev_year
      current_rev_year = "#{cur_year.to_i-1}-#{cur_year_short.to_i}"
    else
      current_rev_year = "#{cur_year.to_i}-#{cur_year_short.to_i+1}"
    end
    return current_rev_year
  end
end
