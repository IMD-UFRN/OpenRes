# -*- encoding : utf-8 -*-
module CanDecideQuery

  def can_be_decided_over?(ap_user)
    return true if ap_user.role == "admin"
    return false if (ap_user.role == "basic" || ap_user.role == "receptionist" || ! ( (sector_ids - ap_user.sector_ids).length <  sector_ids.length))
    return true
  end

end
