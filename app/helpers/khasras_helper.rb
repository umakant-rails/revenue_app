module KhasrasHelper

  def get_village_details(request)
    districts = Village.all.pluck(:district).uniq

    r_village = request.khasras.blank? ? request.village : request.khasras.last.village
    village_list = Village.where(district: r_village.district)

    tehsils = village_list.pluck(:tehsil).uniq
    circles = village_list.where(tehsil: r_village.tehsil).pluck(:ri).uniq
    villages = village_list.where(ri: r_village.ri).collect{ |v| [v.village, v.id] }

    return [districts, tehsils, circles, villages]
  end

  def get_participants(request)
    request.participants.where("name is not null")
  end

end
