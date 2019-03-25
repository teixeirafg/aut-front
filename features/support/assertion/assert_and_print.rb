require 'rspec'
module AssertAndPrint

  def expecting(condition, expected, description)
    if (condition == expected)
      log_info description
      status = 'passed'
    else
      log_error description
      status = 'failed'
    end
    $count_img_scenario = $count_img_scenario + 1
    PrintVV.new.scenario_print $count_img_scenario.to_s + "_" + description, status
    begin
      expect(condition).to eql(expected)
    rescue StandardError
      sleep 5
      begin
        expect(condition).to eql(expected)
      rescue StandardError
        raise "Erro no passo #{description}"
      end
    end

  end

  def tracing(description, screenshot = false)
    log_info description
    if LOG_FULL || screenshot
      $count_img_scenario = $count_img_scenario + 1
      PrintVV.new.scenario_print $count_img_scenario.to_s + "_" + description, 'passed'
    end

  end

  def tracing_error(description, screenshot = true)
    log_error description

    unless screenshot
      PrintVV.new.scenario_print description, 'failed'
    end

    expect(true).to eql(false)
  end

  def tracing_and_raise_error(description, screenshot = true)
    msg = log_error description

    unless screenshot
      PrintVV.new.scenario_print description, 'failed'
    end
    $RAISE_ERROR = msg
    raise "Ocorreu um erro, verifique Hooks/After para evidência e log detalhado"
  end

  private

  def log_warning warning_msg
    msg = "[WARNING]: #{warning_msg}"
    puts msg
    $LOG.warn warning_msg
  end

  def log_info info_msg
    msg = "[INFO]: #{info_msg}"
    puts msg
    $LOG.info info_msg
  end

  def log_error error_msg
    if MOBILE
      plat = "Mobile"
    else
      plat = "Desktop"
    end

    msg = "[ERRO]: #{error_msg}
          *** Detalhes do erro ***
          Data: #{Time.now.strftime('%d/%m/%Y').to_s}
          Horário: #{Time.now.strftime('%H:%M:%S')}
          Site: #{$current_host}
          Host: #{$ip_host}
          Plataforma: #{plat}
          Ambiente: #{AMBIENTE.upcase}"
    puts msg
    $LOG.error msg
    msg
  end


end