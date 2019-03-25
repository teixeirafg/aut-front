module Iframes


  @description
  @frame_id
  @frame_name

  def define_frame(frame_name)
    discover = DiscoverFrame.new
    discover.discover_frame(frame_name)

    @description = discover.description
    @frame_id = discover.frame_id
    @frame_name = discover.frame_name
  end


  def enter_frame (frame, fail = false)
    WaitPage.new
    retries = 0
    define_frame frame
    begin
      sleep 1
      page.driver.browser.switch_to.frame @frame_id
    rescue StandardError
      sleep 1
      retries += 1
      if retries <= 3
        retry
      else
        if fail
          frame_error_log
        end
      end
    end
  end

  def enter_frame_desktop frame
    unless MOBILE
      enter_frame frame
    end
    false
  end

  def enter_frame_mobile frame
    if MOBILE
      enter_frame frame
    end
    false
  end

  def exit_frame
    begin
      page.driver.browser.switch_to.default_content
      true
    rescue StandardError
      false
    end
  end

  def exit_frame_desktop
    unless MOBILE
      exit_frame
    end
    false
  end

  def exit_frame_mobile
    if MOBILE
      exit_frame
    end
    false
  end

  def frame_error_log
    error = "Frame não encontrado #{@frame_name}. ID: #{@frame_id}. Descrição: #{@description}"
    tracing_and_raise_error error
  end

end