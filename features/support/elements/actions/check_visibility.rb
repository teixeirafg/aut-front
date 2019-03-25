module CheckVisibility

  def is_visible_el (el)
    find_el_exists el
  end

  def is_visible_el_desktop (el)
    unless MOBILE
      find_el_exists el
    end
  end

  def is_visible_el_mobile (el)
    if MOBILE
      find_el_exists el
    end
  end

  def is_visible_list_el (el)
    elements = find_all_els_exists el
    if elements.size > 0
      true
    else
      false
    end
  end

  def is_visible_list_el_mobile (el)
    if MOBILE
      is_visible_list_el el
    end
  end

  def is_visible_list_el_desktop (el)
    unless MOBILE
      is_visible_list_el el
    end
  end





end