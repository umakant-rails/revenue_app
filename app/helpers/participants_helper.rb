module ParticipantsHelper
  
  def applicant_name(request, with_address=false)
    applicant = request.participants.applicant

    applicant_str = applicant.name + " " + applicant.relation + " " + applicant.gaurdian 
    applicant_str = applicant_str + " निवासी " + applicant.address if with_address 
    return applicant_str
  end
  
  def participant_names(request, type, with_address=false, is_short=false)
    arr = []
    participant_arr = ''

    if type == "buyer"
      participant_arr = request.participants.buyers
    elsif type == "seller"
      participant_arr = request.participants.sellers
    end

    participant_arr && participant_arr.each do | participant |
      participant_tmp_str = "<strong>" + participant.name + " " + participant.relation + " " + participant.gaurdian + "</strong>"
      participant_tmp_str = participant_tmp_str + " निवासी <strong>" + participant.address + "</strong>" if with_address
      arr.push(participant_tmp_str) 
    end
    
    if is_short and arr.length > 1
      return arr[0] + " एवं अन्य " + (arr.length - 1).to_s
    else
      return arr.join(", ")
    end
  end

  # def participant_name(participant)
  #   [participant.name, participant.relation, participant.gaurdian].join(" ")
  # end

  # def add_evm_suffix(arr)
  #   return [arr[0..arr.length-2].join(", "), "एवं " + arr[arr.length-1]].join(", ") if arr.length > 2
  #   return [arr[0], "एवं " + arr[arr.length-1]].join(" ") if arr.length > 1
  #   return arr[0]
  # end

  # def fout_persons(request)
  #   arr = []
  #   f_persons = request.participants.fout_person

  #   if f_persons.length > 2
  #     f_persons.fout_person.each do | f_person |
  #       arr.push(participant_name(f_person))
  #     end
  #   elsif f_persons.length > 1
  #     f_persons.fout_person.each do | f_person |
  #       arr.push(participant_name(f_person))
  #     end
  #   else
  #     f_person = f_persons.first
  #     arr.push([f_person.name, f_person.relation, f_person.gaurdian].join(" "))
  #   end
  #   add_evm_suffix(arr)
  # end

  # def participant_names_arr(request, with_parent_name=false, with_address=false)
  #   arr = []
  #   request.participants.each do | p | 
  #     tmp = [p.name]
  #     tmp.push(p.relation + " " + p.gaurdian) if with_parent_name
  #     tmp.push(" निवासी " + p.address) if with_address
  #     arr.push(tmp.join(" "))
  #   end
  #   return arr
  # end

  # def participant_names(request, with_address=false)
  #   arr = participant_names_arr(request, true, with_address)  
  #   return arr.join(", ")
  # end

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

  def varsan_names1(request, is_short=false, arr=[])
    if is_short
      arr = request.participants.fout_person.collect { | f_person | varsan_names(f_person) }
      arr = arr.flatten
      return arr.length>3 ? [arr[0..2].join(", "), "वगैरह"].join(" ") : arr.join(", ")
    else
      str = ''
      request.participants.fout_person.each do | f_person | 
        str = str + "मृतक <strong>#{participant_name(f_person)} </strong> के वारसान <strong> 
          #{varsan_names(f_person, []).join(', ')} </strong>"
      end

      return str
    end
  end

end
