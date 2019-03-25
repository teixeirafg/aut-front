module Select

  ##
  # Select default tanto para desktop quanto para mobile
  def select_el(el, value, options = {}, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      element.select(value, options)
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        select_error_value_log el, value
      end
    end
  end

  def select_random_el(el, log = false)
    begin
      retries ||= 0
      elements = find_all_els(el)
      elements.size > 10 ? num = 10 : num = elements.size
      elements[rand(0...num)].click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        select_error_log el
      end
    end
  end

  def select_random_el_desktop(el, log = false)
    unless MOBILE
      select_random_el el, log
    end
  end

  def select_random_el_mobile(el, log = false)
    if MOBILE
      select_random_el el, log
    end
  end

  def select_random_el_not_first(el, log = false)
    begin
      retries ||= 0
      elements = find_all_els(el)
      elements.size > 10 ? num = 10 : num = elements.size
      elements[rand(1...num)].click

    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        select_error_log el
      end
    end
  end


  def select_text_el(el, text, log = false)
    begin
      retries ||= 0
      elements = find_all_els(el)

      elements.each do |el|
        next unless el.text == text
        el.click
       # click_log el, log
        break
      end
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        select_error_log el
      end
    end
  end

  def select_child_el(element, child_el, value, options = {}, log = false)
    begin
      retries ||= 0
      element = find_child_el(element, child_el)
      element.select(value, options)
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        msg = "Erro ao clicar no elemento " + element.to_s
        tracing_and_raise_error msg
      end
    end
  end

  private

  def select_error_log el
    error = "Erro ao selecionar um valor para o elemento #{el}"
    tracing_and_raise_error error
  end

  def select_error_value_log el, value
    error = "Erro ao selecionar: " + value + " para o elemento #{el}"
    tracing_and_raise_error error
  end


end