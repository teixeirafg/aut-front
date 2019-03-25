class DiscoverElement

  attr_reader :finder
  attr_reader :element
  attr_reader :description
  attr_reader :specific_element
  attr_reader :specific_finder
  attr_reader :element_name

  @@page_name = ""
  def discover(el_name)
    MOBILE ? plat = 'mobile' : plat = 'desktop'
    @element_name = el_name
    els = el_name.split(/\.(?=[\w])/)
    @@page_name = els[0]
    file = load_file

    begin

      @description = "#{file[el_name]['description']}"
      @finder = "#{file[el_name][plat]['finder']}"
      @finder = @finder.parameterize.underscore.to_sym
      @element = "#{file[el_name][plat]['default']}"
      @specific_element = "#{file[el_name][plat][ENV['bandeira']]}"
      @specific_finder = "#{file[el_name][plat]["finder_#{ENV['bandeira']}"]}"
    rescue StandardError
      msg = "Por favor, verifique se o elemento #{el_name} existe no arquivo yml, se está escrito corretamente e se os dados estão devidamente informados"
      raise msg
    end

    unless @specific_element.to_s.empty?
      @element = @specific_element
    end

    unless @specific_finder.to_s.empty?
      @specific_finder = @specific_finder.parameterize.underscore.to_sym
      @finder = @specific_finder
    end

    if @element.to_s.empty?
      msg = "Seletor para o elemento #{el_name} está vazio"
      raise msg
    end

    if @finder.to_s.empty?
      msg = "Tipo de locator para o elemento #{el_name} está vazio"
      raise msg
    end

  end

  def load_file
    begin
      if @@page_name.include? 'section'
        file = YAML.load_file("features/pages/sections/#{@@page_name}/#{@@page_name}.yml")
      else
        file = YAML.load_file("features/pages/#{@@page_name}/#{@@page_name}.yml")
      end
      file
    rescue StandardError
      msg = "Atenção, não foi possível encontrar o arquivo yml referente à pagina: '#{@@page_name}'. Verifique se a página existe ou se o nome está correto para o elemento #{@element_name}"
      raise msg
    end
  end

end