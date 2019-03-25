class WaitPage

  ##
  # O método sempre aguardará 1 segundo para o caso o problema não seja carregamento de ajax, e sim algum outro motivo de espera
  def initialize(full=true)
      wait_ajax_requests
      if full
        wait_for_page_to_load
      end
  end

  def wait_for_page_to_load(options = {})
    begin
      options[:timeout] ||= 5
      wait = Selenium::WebDriver::Wait.new(options)
      wait.until {Capybara.execute_script('var browserState = document.readyState; return browserState;') == "complete"}
    rescue StandardError
      begin
        wait.until {Capybara.execute_script('return jQuery.active') == "0"}
      rescue StandardError
          Capybara.execute_script('return window.stop()')
      end
    end

  end

  def wait_ajax_requests

    ##
    # Aguarda apenas o tempo necessário para finalização de um request
    begin
      Timeout.timeout(0.2) do
        loop while finished_all_ajax_requests?
      end
    rescue
    end

    ##
    # Aguarda tempo necessário para finalização de todos os requests
    begin
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
        sleep AJAX_COMPLETE_WAIT
      end
    rescue
    end
  end

end