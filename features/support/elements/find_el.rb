module FindEl

  @page_name
  @description
  @finder
  @el_locator

  def define_finders(el_name)
    discover = DiscoverElement.new
    discover.discover(el_name)

    @description = discover.description
    @finder = discover.finder
    @el_locator = discover.element

    WaitPage.new
  end

  def find_el(el_name)
    #WaitPage.new
    retries = 0
    define_finders el_name
    begin
      page.find(@finder, @el_locator)
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 3
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_el_attr(el_name, attr)
    #WaitPage.new
    retries = 0
    define_finders el_name
    begin
      attribute = page.find(@finder, @el_locator)[attr]
      attribute
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 3
        retry
      else
        find_el_log_error el_name
      end
    end
  end


  def find_all_els(el_name)
    #WaitPage.new
    define_finders el_name
    retries = 0
    begin
      wait_until_el_displayed @finder, @el_locator
      els = page.find_all(@finder, @el_locator)

      if els.size == 0
        find_el_log_error el_name
      else
        els
      end
    rescue StandardError
      retries += 1
      if retries <= 3
        wait_until_el_displayed @finder, @el_locator
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_all_els_exists(el_name, seconds = 4)
   # WaitPage.new
    define_finders el_name
    retries = 0
    begin
      els = page.find_all(@finder, @el_locator)
      els
    rescue StandardError
      retries += 1
      if retries <= 3
        wait_until_el_displayed @finder, @el_locator, seconds
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_el_exists(el_name)
    WaitPage.new
    define_finders el_name
    page.has_selector? @finder, @el_locator
  end

  def find_els_exists(el_name, seconds = 4)
    #WaitPage.new
    define_finders el_name
    retries = 0
    begin
      page.find_all(@finder, @el_locator)
      true
    rescue StandardError
      retries += 1
      if retries <= 3
        wait_until_el_displayed @finder, @el_locator, seconds
        retry
      else
        false
      end
    end
  end

  def find_child_el(element, el_name)
    #WaitPage.new
    retries = 0
    define_finders el_name
    begin
      element.find(@finder, @el_locator)
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 3
        retry
      else
        find_el_log_error el_name
      end
    end
  end


  def find_el_first(el_name)
    #WaitPage.new
    retries ||= 0
    define_finders el_name
    begin
      page.find(@finder, @el_locator, :match => :first)
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 3
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_el_xpath(xpath)
    #WaitPage.new
    retries = 0
    begin
      page.find(:xpath, xpath)
    rescue StandardError
      wait_until_el_displayed :xpath, xpath
      retries += 1
      if retries <= 3
        retry
      else
        tracing_error 'Elemento não encontrado pelo xpath: ' + xpath
      end
    end
  end

  def find_focus(el_name)
   # WaitPage.new
    define_finders el_name
    retries = 0
    begin
      if @finder.eql? 'xpath'
        tracing_error "Não foi possível realizar o foco no elemento. Verifique "
        +"se está utilizando expressao CSS para o finder. Descrição: #{@description}"
      else
        page.find(@finder, @el_locator)
        page.execute_script "$('#{@el_locator}').focus()"
      end
    rescue StandardError
      wait_until_el_displayed :xpath, xpath
      retries += 1
      if retries <= 3
        retry
      else
        tracing_error 'Elemento não encontrado pelo xpath: ' + xpath
      end
    end
  end

  private

  def find_el_log_error el_name
    error = "Elemento não encontrado: #{el_name}. Locator: #{@el_locator}. Descrição: #{@description}"
    tracing_and_raise_error error
  end

end