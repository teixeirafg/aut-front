module SendKeys

  # sendkeys básico
  def send_keys_el(el, value, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      element.set value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end

  def send_keys_el_xpath(xpath, value, log = false)
    begin
      retries ||= 0
      element = find_el_xpath(xpath)
      element.set value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        tracing_error 'Erro ao enviar texto ' + value + 'para o elemento com o xpath: ' + xpath
      end
    end
  end

  def send_keys_el_desktop(el, value, log = false)
    unless MOBILE
      send_keys_el el, value, log
    end
  end

  def send_keys_el_mobile(el, value, log = false)
    if MOBILE
      send_keys_el el, value, log
    end
  end

  def clear_send_keys_el(el, value, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      element.clear
      element.set value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end

  def clear_send_keys_el_mobile(el, value, log = false)
    if MOBILE
      clear_send_keys_el el, value, log
    end
  end

  def clear_send_keys_el_desktop(el, value, log = false)
    unless MOBILE
      clear_send_keys_el el, value, log
    end
  end

  private

  def keys_error_log el, value
    error = "Erro ao enviar o texto: " + value + " para o elemento " + el
    tracing_and_raise_error error
  end

end