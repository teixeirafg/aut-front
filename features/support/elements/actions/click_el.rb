module ClickEl

  @description
  @finder
  @el_locator

  ##
  # ClickEl default tanto para desktop quanto para mobile
  def click_el(el, log = false)
    retries = 0
    begin
      element = find_el(el)
      element.click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def click_solved_el(el, log = false)
    el.click
  end



  def click_text_el(el, text, log = false)
    retries = 0
    ret = false
    text_list = []
    begin
      elements = find_all_els(el)
      elements.each do |el|
        text_list << el.text
        next unless el.text == text
        ret = true
        el.click
      end

      unless ret
        error = "Nenhum elemento com o texto #{text} foi encontrado. Os textos presentados foram: #{text_list}"
        tracing_and_raise_error error
        raise error
      end

    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def click_el_random(el, log = false)
    retries = 0
    begin
      elements = find_all_els(el)
      elements[rand(0...elements.size)].click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end


  ##
  # ClickEl default para mobile
  def click_el_mobile(el, log = false)
    if MOBILE
      click_el el, log
    end
  end

  ##
  # ClickEl default para desktop
  def click_el_desktop(el, log = false)
    unless MOBILE
      click_el el, log
    end

  end

  def click_el_script(el)
    define_finders el
    retries = 0
    begin
      find_el el
      page.execute_script("document.querySelector('#{@el_locator}').click();")
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  ##
  # ClickEl first
  def click_el_first(el, log = false)
    retries = 0
    begin
      element = find_el(el)
      element.first.click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  private

  @description
  @finder
  @el_locator

  def define_finders(el_name)
    discover = DiscoverElement.new
    discover.discover(el_name)

    @description = discover.description
    @finder = discover.finder
    @el_locator = discover.element
  end

  def click_error_log el
    error = "Erro ao clicar no elemento " + el
    tracing_and_raise_error error
  end

end