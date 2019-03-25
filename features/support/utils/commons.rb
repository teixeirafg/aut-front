module Commons

  def go_to(url, time = 0)
    visit url
    sleep time
  end

  def random_boolean
    random_boolean = [true, false].sample
    random_boolean
  end

  def random_data (text, type)
    if type.casecmp('random')
      case type.upcase
      when 'NAME'
        text = Faker::Name.first_name
      when 'FULL_NAME'
        text = Faker::Name.name
      when 'VERB'
        text = Faker::Verb.base
      when 'CPF'
        text = Faker::CPF.number
      when 'CNPJ'
        text = Faker::CNPJ.number
      when 'SITE'
        text = "http://www.#{Faker::Name.first_name}.com.br"
      when 'DAY'
        text = rand(01...29).to_s
      when 'MONTH'
        text = rand(01...12).to_s
      when 'FULL_YEAR_PAST'
        text = rand(1960...1996).to_s
      when 'FULL_YEAR_FUTURE'
        text = rand(2019...2099).to_s
      when 'FULL_YEAR_ALL'
        text = rand(1960...2099).to_s
      when 'YEAR_PAST'
        text = rand(60...96).to_s
      when 'YEAR_FUTURE'
        text = rand(19...99).to_s
      when 'YEAR_ALL'
        text = rand(60...99).to_s
      when 'PHONE_NUMBER'
        text = rand(111111111...999999999).to_s
      when 'DDD'
        text = rand(10...99).to_s
      when 'BIRTH_BIZARRE_MOBILE'
        year = ['1986', '1987', '1988', '1989', '1990', '1991', '1992']
        year = year.shuffle.first.to_s
        month = ['01', '03', '06', '08', '10', '12']
        month = month.shuffle.first.to_s
        day = rand(01...29).to_s

        text = "#{day}/#{month}/#{year}"
      when 'EMAIL'
        text = 'vv_qa_bot_front' + Faker::Number.between(1, 1000000).to_s + '@mailinator.com'
      else
        tracing_and_raise_error "A opção para geração de massa randomica #{type} é inválida"
      end
    end
    text
  end

  def random_sku sku_type, db=false
    url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['home']}"
    sku_url = sort_sku sku_type, db
    $sku = sku_url
    if current_store.casecmp('barateiro')
      if MOBILE
        curr_url = Capybara.current_url
        curr_url.slice! '/conta/menu'
        url = curr_url + '/-' + sku_url + '.html'
      else
        url = url + '/produto/' + sku_url + '.html'
      end
    else
      url = url + '/' + sku_url + '.html'
    end
    url
  end

  private

  def sort_sku sku_type, db = false
    if db
      sku = get_sku_db
      sku = sku.sample.first.to_s
    else
      product_file = YAML.load_file('features/support/data/massa/produto.yml')
      sku = "#{product_file['sku'][ENV['BANDEIRA']][sku_type]}"
      sku = sku.split(",")
      sku = sku[rand(0...sku.length)]
    end
    sku
  end

  def scroll_page_down(value = '250')
    page.execute_script("window.scrollBy(0,#{value})", '')
  end

  def scroll_page_up(value = '-250')
    page.execute_script("window.scrollBy(0,-#{value})", '')
  end

  def current_store
    BANDEIRA
  end

  def delete_sku_cart_api(email, senha)
    step 'logo pela api para realizar exclusão no front', table(%{
      | email | #{email} |
      | senha | #{senha} |
    })
    step 'informo a propriedade id_cliente'
    step 'faço uma requisição DELETE para o serviço ExcluirProdutosDoCarrinho'
    step 'serviço ExcluirProdutosDoCarrinho deve responder com 200'
  end

  def create_user_api
    @request_cliente2 = RequestCliente.cadastro_cliente
    @cliente = criar_cliente.put_criar_usuario(@request_cliente2)
    expect(@cliente['Salvar2Result']['Erro']).to be false
    @request_adicionar_endereco = RequestEndereco.request_adicionar_endereco('sp')
    obter_endereco_cliente.put_endereco_meu_perfil(@cliente, @request_adicionar_endereco)

    $usuario_senha = 'Varejo123'

    @cliente
  end

  def create_address user, password, cep

    user_list = user.split(",")

    user_list.each do |x|
      request_consulta = RequestLogin.request_login(x, password)
      response = realizar_login.post_login(request_consulta)
      @request_adicionar_endereco = RequestEndereco.request_adicionar_endereco('sp')
      obter_endereco_cliente.put_endereco_meu_perfil(response, @request_adicionar_endereco)

    end

  end

  def get_sku_db
    mongo.create_connection
    sku = mongo_sku.get_sku
    sku
  end


end
