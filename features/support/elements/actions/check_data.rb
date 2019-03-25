module CheckData

  def get_text_el el
    find_el el
    el.text
  end

  def get_attribute_el (el, attr)
    attribute = find_el_attr el, attr
    attribute
  end


  def get_elements_size (el)
    elements = find_all_els(el)
    elements.size
  end

  def check_page_text (text)
    page.has_content? text
  end



end