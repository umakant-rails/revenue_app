module RequestsHelper

  def cal_rakba(request)
    arr = []
    rkba = []
    unit = ''

    request.khasras.each do | kh | 
      if kh.unit == 'व.फु.'
        unit = 'व.फु.'
        arr.push(kh.sold_rakba.to_s + " " + kh.unit)
        rkba.push(kh.sold_rakba.to_f)
      elsif  kh.unit == 'व.मी.'
        unit = 'व.मी.'
        arr.push(('%.2f' % kh.sold_rakba).to_s + " " + kh.unit)
        rkba.push(kh.sold_rakba.to_f)
      elsif kh.unit == 'हे.'
        unit = 'हे.'
        arr.push(('%.4f' % kh.sold_rakba).to_s + " " + kh.unit)
        rkba.push(kh.sold_rakba.to_f)
      end
    end

    total_sold_rakba = rkba.sum
    if unit == 'व.फु.'
      # total_sold_rakba = ('%.0f' % rkba.sum).to_s + " " + unit
      (total_sold_rakba/107639).round(4)
    elsif unit == 'व.मी.'
      (total_sold_rakba/10000).round(4)
      # total_sold_rakba = ('%.2f' % rkba.sum).to_s + " " + unit
    else
      total_sold_rakba
      # total_sold_rakba = ('%.4f' % rkba.sum).to_s + " " + unit
    end

    return [arr.join(", "), total_sold_rakba]
  end

  def get_khasra_detail(request)
    khasra_tmp = request.khasras.pluck(:khasra).join(", ")
    rakba_with_unit = request.khasras.collect{ |k| ('%.4f' % k.rakba).to_s + " हे." }.join(", ")
    # sold_rakba_with_unit = request.khasras.collect{ |k| ('%.4f' % k.sold_rakba).to_s + " " + k.unit }.join(", ")
    # total_sold_rakba = request.khasras.collect{ |k| k.sold_rakba.to_f }.sum
    total_rakba = request.khasras.collect{ |k| k.rakba.to_f }.sum

    sold_rakba_with_unit, total_sold_rakba = cal_rakba(request) rescue nil
    is_complete_rakba_sold = (total_rakba == total_sold_rakba) ? true : false

    return {
      request: request,
      khasra: khasra_tmp, 
      kh_rakba: rakba_with_unit, 
      sold_rakba: sold_rakba_with_unit, 
      total_sold_rakba: total_sold_rakba, #(('%.4f' % total_sold_rakba) + " " + request.khasras.last.unit), 
      is_complete_rakba_sold: is_complete_rakba_sold
    }
  end

  def khasara_string(request, village, khasras)
    tmp_string = ''

    tmp_string = tmp_string + "मौजा <strong>#{village.village}</strong> पटवारी हल्का नंबर <strong>#{village.halka_number}</strong>" 
    tmp_string = tmp_string +  " में स्थित भूमि खसरा नंबर <strong>#{khasras.pluck(:khasra).join(', ') }</strong> "

    if khasras.length > 1
      tmp_string = tmp_string +  "रकबा क्रमशः <strong>#{khasras.collect{ |k| ('%.4f' %k.rakba) + " हे." }.join(', ') }</strong> " 
    else
      tmp_string = tmp_string +  "रकबा <strong>#{khasras.collect{ |k| ('%.4f' %k.rakba) + " हे." }.join(', ') }</strong> " 
    end

    if request.request_type.name == "नामांतरण"
      if khasras.length > 1 && (khasras.pluck(:sold_rakba) - [""]).length == 1
        khasra = khasras.where("sold_rakba != ''")[0]
        s_rakba = (khasra.unit != "हे.") ? khasra.sold_rakba : ('%.4f' % khasra.sold_rakba)
        tmp_string = tmp_string +  "में से क्रय रकबा <strong>#{ s_rakba + " "+ khasra.unit  }</strong>"
      elsif khasras.length == 1 && khasras[0].unit  != "हे."
        tmp_string = tmp_string +  "में से क्रय रकबा <strong>#{ khasras[0].sold_rakba + " "+ khasras[0].unit  }</strong>"
      else
        tmp_string = tmp_string +  "में से क्रय रकबा क्रमशः <strong>#{khasras.collect{ |k| ('%.4f' % k.sold_rakba) + " "+ k.unit }.join(', ') }</strong> कुल रकबा "
        tmp_string = tmp_string +  "<strong>#{'%.4f' % khasras.collect{ |k| k.sold_rakba.to_f }.sum } हे.</strong>"
      end

    elsif request.request_type.name == "फौती"
      tmp_string = tmp_string +  " कुल रकबा "
      tmp_string = tmp_string +  "<strong>#{'%.4f' % khasras.collect{ |k| k.sold_rakba.to_f }.sum } हे.</strong>"
    else
      tmp_string = tmp_string +  " कुल रकबा "
      tmp_string = tmp_string +  "<strong>#{'%.4f' % khasras.collect{ |k| k.rakba.to_f }.sum } हे.</strong>"
    end

    tmp_string
  end

  def khasra_description(request, village=nil)

    villages =  village.blank? ? Village.where("id in (?)", request.khasras.pluck(:village_id)) : [village]
    village_details = ""

    if villages.length > 1
      villages.each_with_index do | village, indx |
        khasras = request.khasras.where(village_id: village.id)
        suffix = (indx > 0 && indx < villages.length-1) ? ", " : (indx == villages.length-1 ? " एवं " : "")

        village_details = village_details + (suffix.present? ? suffix : "")
        village_details = village_details + khasara_string(request,village, khasras)
      end 
    else
      khasras = request.khasras.where(village_id: villages[0].id)
      village_details = village_details + khasara_string(request, villages[0], khasras)
    end 
    village_details
  end

end
