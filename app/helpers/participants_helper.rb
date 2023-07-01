module ParticipantsHelper
  
  def applicant_name(request, with_address=false)
    applicant = request.participants.applicant
    participant_name(applicant, with_address)
  end

  def participant_name(participant, with_address=false)
    participant_str = ''
    if participant.present?
      participant_str = "<strong>" + participant.name + " " + participant.relation + " " + participant.gaurdian + "</strong>"
      participant_str = participant_str + " निवासी <strong>" + participant.address + "</strong>" if with_address 
    end
    return participant_str
  end
  
  def participant_names(request, type, with_address=false, is_short=false)
    arr = []
    participant_arr = ''

    if type == "buyer"
      participant_arr = request.participants.buyers
    elsif type == "seller"
      participant_arr = request.participants.sellers
    elsif type == "dead_person"
      participant_arr = request.participants.fout_person
    elsif type == "hissedar"
      participant_arr = request.participants.hissedar
     elsif type == "land_owner"
      participant_arr = request.participants.land_owner
    elsif type == "batwara_daughters"
      participant_arr = request.participants.batwara_daughters
    end

    participant_arr && participant_arr.each do | participant |
      arr.push(participant_name(participant, with_address)) 
    end
    
    if is_short and arr.length > 1
      return arr[0] + " एवं अन्य " + (arr.length - 1).to_s
    else
      return arr.join(", ")
    end
  end

  def add_evm_suffix(arr)
    return [arr[0..arr.length-2].join(", "), "एवं " + arr[arr.length-1]].join(", ") if arr.length > 2
    return [arr[0], "एवं " + arr[arr.length-1]].join(" ") if arr.length > 1
    return arr[0]
  end

  def get_varsan_status(participant, relation_dipslay=false)
    status = []

    if participant.depth > 1 && relation_dipslay
      status.push(participant.relation)
    end

    if participant.is_dead && participant.children.present?
      status.push('फौत')
    elsif participant.is_dead && participant.children.blank?
     ['पत्नी', 'पति'].index(participant.relation_to_deceased).present? ? status.push('फौत'): status.push('ला-औलाद फौत')
    elsif participant.is_nabalig
      status.push('नाबालिग') 
    end

    return status.length > 0 ? "("+ status.join(", ") + ")" : ""
  end

  def varsan_names(participant, arr=[])
    participant.children.group_by(&:relation_to_deceased).each do |relation, varsans|
      gaurdian = ''
      tmp = []
      balee = ''
      varsans.each do | vrsn |
        gaurdian = vrsn.gaurdian
        if vrsn.is_nabalig
          tmp.push("#{vrsn.name} (नाबालिग)")
          balee = vrsn.balee
        elsif vrsn.is_dead && vrsn.children.present?
          tmp.push("#{vrsn.name} (फौत)")
        elsif vrsn.is_dead && vrsn.children.blank?
          tmp.push("#{vrsn.name} (ला-औलाद फौत)")
        else
          tmp.push("#{vrsn.name}")
        end
      end
      arr.push([tmp.join(", "), relation, gaurdian.strip, balee].join(" ")) if tmp.present?
    end

    participant.children.fout_participants.each do | f_person |
      if f_person.children
       vrsn = varsan_names(f_person, arr) 
      end
    end
    return arr
  end

  def dead_persions_varsan(request, is_short=false)
    str = ''
    arr = request.participants.fout_person.collect { | f_person | varsan_names(f_person) }
    arr = arr.flatten

    if is_short
      str =  arr.length>3 ? [arr[0..2].join(", "), "वगैरह"].join(" ") : arr.join(", ")
      str = "<strong>#{str}</strong>"
    else
      str = "<strong>#{arr.join(", ")}</strong>"      
    end
    return str
  end

end
