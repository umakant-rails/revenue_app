module RequestsHelper

  def applicant_name(request, with_address=false)
    arr = []
    arr.push(request.applicant + " " + request.relation + " " + request.gaurdian)
    arr.push("निवासी " + request.address) if with_address
    return arr.join(" ")
  end

  def applicant_names(request, with_address=false, is_short=false)
    arr = []
    request.participants.applicants.each do | applicant |
      arr.push(applicant.name + " " + applicant.relation + " " + applicant.gaurdian)
      arr.push("निवासी " + applicant.address) if with_address
    end
    if is_short and arr.length > 1
      return arr[0] + " एवं अन्य " + (arr.length - 1).to_s
    else
      return arr.join(", ")
    end
  end

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

    if unit == 'व.फु.'
      total_sold_rakba = ('%.0f' % rkba.sum).to_s + " " + unit
    elsif unit == 'व.मी.'
      total_sold_rakba = ('%.2f' % rkba.sum).to_s + " " + unit
    else
      total_sold_rakba = ('%.4f' % rkba.sum).to_s + " " + unit
    end

    return [arr.join(", "), total_sold_rakba]
  end

  def get_khasra_detail(request)
    khasra_tmp = request.khasras.pluck(:khasra).join(", ")
    rakba_with_unit = request.khasras.collect{ |k| ('%.4f' % k.rakba).to_s + " हे." }.join(", ")
    # sold_rakba_with_unit = request.khasras.collect{ |k| ('%.4f' % k.sold_rakba).to_s + " " + k.unit }.join(", ")
    # total_sold_rakba = request.khasras.collect{ |k| k.sold_rakba.to_f }.sum
    total_rakba = request.khasras.collect{ |k| k.rakba.to_f }.sum

    sold_rakba_with_unit, total_sold_rakba = cal_rakba(request)
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

  def village_description(request)
    villages =  request.khasras.pluck(:village_id).uniq
    village_details = ""

    if villages.length > 1
      villages.each_with_index do | village_id, indx |
        village = Village.find(village_id)
        khasras = request.khasras.where(village_id: village.id)
        suffix = (indx > 0 && indx < villages.length-1) ? ", " :(indx == villages.length-1 ? " एवं " : "")

        village_details = village_details + (suffix.present? ? suffix : "")

        village_details = village_details + "ग्राम <strong>#{village.village}</strong> पटवारी हल्का नंबर " + 
        "<strong>#{village.halka_number}</strong> खसरा नंबर <strong>#{khasras.pluck(:khasra).join(', ') }</strong> "+
        "रकबा <strong>#{khasras.collect{ |k| k.sold_rakba + " "+ k.unit }.join(', ') }</strong> कुल रकबा "+
        "<strong>#{khasras.collect{ |k| k.rakba.to_f }.sum } हे.</strong>"
      end 
    else
      khasras = request.khasras
      village_details = "ग्राम <strong> #{request.village.village}</strong> पटवारी हल्का नंबर " +
      "<strong>#{request.village.halka_number }</strong> खसरा नंबर <strong>#{khasras.pluck(:khasra).join(', ') }</strong> रकबा "+
      "<strong>#{khasras.collect{ |k| k.sold_rakba + " " +k.unit }.join(', ') }</strong> कुल रकबा "+
      "<strong>#{khasras.collect{ |k| k.rakba.to_f }.sum} हे.</strong>" 
    end 
    village_details
  end

end
