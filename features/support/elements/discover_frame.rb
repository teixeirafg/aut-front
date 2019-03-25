class DiscoverFrame

  attr_reader :frame_id
  attr_reader :description
  attr_reader :specific_frame_id
  attr_reader :specific_finder
  attr_reader :frame_name

  @@page_name = ""
  def discover_frame(frame_name)
    MOBILE ? plat = 'mobile' : plat = 'desktop'
    @frame_name = frame_name

    els = frame_name.split(/\.(?=[\w])/)
    @@page_name = els[0]
    file = load_file

    begin

      @description = "#{file[frame_name]['description']}"
      @frame_id = "#{file[frame_name][plat]['default']}"
      @specific_frame_id = "#{file[frame_name][plat][ENV['bandeira']]}"
    rescue StandardError
      msg = "Por favor, verifique se o frame #{frame_name} existe no arquivo yml, se está escrito corretamente e se os dados estão devidamente informados"
      raise msg
    end

    unless @specific_frame_id.to_s.empty?
      @frame_id = @specific_frame_id
    end

    unless @specific_finder.to_s.empty?
      @specific_finder = @specific_finder.parameterize.underscore.to_sym
      @finder = @specific_finder
    end

    if @frame_id.to_s.empty?
      msg = "ID para o frame #{frame_name} está vazio"
      raise msg
    end

  end

  def load_file
    begin
      if @@page_name.include? 'section'
        file = YAML.load_file("features/pages/sections/#{@@page_name}/#{@@page_name}_frame.yml")
      else
        file = YAML.load_file("features/pages/#{@@page_name}/#{@@page_name}_frame.yml")
      end
      file
    rescue StandardError
      msg = "Atenção, não foi possível encontrar o arquivo yml de frames referente à pagina: '#{@@page_name}'. Verifique se a página existe ou se o nome está correto para o frame #{@frame_name}"
      raise msg
    end
  end

end