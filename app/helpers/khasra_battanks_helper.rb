module KhasraBattanksHelper
  
  def batwara_fard_land_owner_tbl(request, khasras, kh_battanks, group_ids, indx)
    tbl_str = ''
    acc_rakba = 0

    if indx == 0 
      tbl_str = "<td rowspan='#{kh_battanks.length + group_ids.length}'> 
        #{raw participant_names(request, 'land_owner')}
      </td>"
    end
    if khasras.length == indx + 1
      tbl_str = tbl_str + "
      <td rowspan='#{kh_battanks.length + group_ids.length - khasras.length+1}'>
        #{khasras[indx].khasra}
      </td>
      <td rowspan='#{kh_battanks.length + group_ids.length - khasras.length+1}'>
        #{'%.4f' % khasras[indx].rakba}
      </td>"
      acc_rakba = acc_rakba + (khasras[indx].rakba.to_f*10000)
    elsif khasras.length > indx
      tbl_str = tbl_str + "<td>#{khasras[indx].khasra}</td>
      <td>#{'%.4f' % khasras[indx].rakba}</td>"
      acc_rakba = acc_rakba + (khasras[indx].rakba.to_f*10000)
    end

    return [tbl_str, acc_rakba]
  end

end
