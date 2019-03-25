require 'open-uri'
require 'prawn'
require 'capybara-screenshot/rspec'

SitePrism::Page.class_eval do
  include Commons, Comercio, ClickEl, SendKeys, Select, CheckVisibility, CheckData, FindEl, Alerts, Iframes, WaitElement, REST, AssertAndPrint
end

SitePrism::Section.class_eval do
  include Commons, Comercio, ClickEl, SendKeys, Select, CheckVisibility, CheckData, FindEl, Alerts, Iframes, WaitElement, REST, AssertAndPrint
end

=begin
Screenshots.class_eval do
  include Commons
end
=end

$pdf_names = []

Before do |scenario|

  Capybara.current_session.driver.browser.manage.delete_all_cookies
  $LOG = Logger.new('automation_log.log')
  $count_img_scenario =  0

  ## Create directory for saved screenshots
  #create_directory_evidences(scenario)
  $Scenario = scenario
  Capybara.current_session.driver.browser.manage.delete_all_cookies

  tracing '---- Executando Cenário: ' + scenario.name.to_s.center(5).upcase
  tracing 'Driver: ' + Capybara.current_driver.to_s

end


After do |scenario|

    scroll_page_up 300
    img = Capybara.page.save_screenshot "#{$file_path}/final_0.png"
    embed img, 'image/png'
    for i in 1..2 do
      img = Capybara.page.save_screenshot "#{$file_path}/final_#{i}.png"
      embed img, 'image/png'
      scroll_page_down 150
    end

  file_logger = Dir.pwd + '/' + $LOG.instance_variable_get(:@logdev).instance_variable_get(:@filename)
  $LOG.close
  FileUtils.mv(file_logger, $file_path, :force => true)

  unless $RAISE_ERROR.nil?
    unless $RAISE_ERROR.empty?
      puts $RAISE_ERROR
      $RAISE_ERROR = ""
    end
  end


  #pdf scenario
end

def pdf scenario
  pdf_name = "#{scenario.name}.pdf"
  $pdf_names << pdf_name

  if $screenshot_final.length > 0
    Prawn::Document.generate(pdf_name) do
      text "CENÁRIO: #{scenario.name}"
      text "DATA: #{Time.now.strftime('%d %m %Y').to_s}"
      text "DETALHES DA EXECUÇÃO"
      text " "

      $screenshot_final.each do |screenshot|
        text screenshot[:description]
        image open(screenshot[:image]), fit: [600, 750], position: :center, position: :center
        start_new_page
      end
    end
    $screenshot_final.clear

  end
end

def merge_pdfs
  if $pdf_names.length > 1
    pdf_file_paths = []
    $pdf_names.each do |names|
      pdf_file_paths << names
    end

    Prawn::Document.generate("feature.pdf", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
      pdf_file_paths.each do |pdf_file|
        if File.exists?(pdf_file)
          pdf_temp_nb_pages = Prawn::Document.new(:template => pdf_file).page_count
          (1..pdf_temp_nb_pages).each do |i|
            pdf.start_new_page(:template => pdf_file, :template_page => i)
          end
        end
      end
    end
  end

end


at_exit do
  #merge_pdfs
  Capybara.current_session.driver.quit
end

