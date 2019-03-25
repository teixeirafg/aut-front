# Classe responsável por fazer as ações básicas na Tela de Identificacao: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Login < SitePrism::Page

      @@input_email = 'login.input_email'
      @@input_senha = 'login.input_senha'
      @@link_meus_pedidos = 'login.link_meus_pedidos'

      def is_login_page
        WaitPage.new
        is_visible_el 'login.title'
      end

      def set_email (email)
        send_keys_el @@input_email, email
      end

      def set_senha (senha)
        send_keys_el @@input_senha, senha
      end

      def do_login_from_properties usuario, soft_login
        get_user usuario
        set_email $usuario_email
        tracing "Usuário sorteado: #{$usuario_email}"
        set_senha $usuario_senha
        skip_captcha($usuario_email, $usuario_senha, soft_login) if ENV['AMBIENTE'].eql? 'prd'
        press_continue
      end

      def do_login(usuario, senha)
        $usuario_email = usuario
        $usuario_senha = senha

        set_email usuario
        set_senha senha

        skip_captcha($usuario_email, $usuario_senha, false) if ENV['AMBIENTE'].eql? 'prd'

        press_continue
      end

      def close_frame
        if MOBILE
          is_frame_on = enter_frame_mobile 'login.social_miner'
          unless is_frame_on
            sleep 6
            enter_frame_mobile 'login.social_miner'
          end

          if is_visible_el 'login.frame_close'
            click_el_script 'login.frame_close'
          end
          exit_frame_mobile
        end
      end

      def press_continue
        if MOBILE || !ENV['AMBIENTE'].eql?('prd')
          begin
            click_el 'login.button_continuar'
          rescue StandardError
            if MOBILE
              close_frame
              if is_visible_el 'login.button_continuar'
                click_el 'login.button_continuar'
              end
            end
          end

          if current_store.casecmp 'extra'
            sleep 3
          end
        end
      end

      def choose_new_user
        is_visible_el_desktop 'login.user_not_registered'
        click_el_desktop 'login.user_not_registered'
        begin
          click_el 'login.button_cadastrar'
        rescue StandardError
          if MOBILE
            close_frame
            if is_visible_el 'login.button_cadastrar'
              click_el 'login.button_cadastrar'
            end
          end
        end
      end

      def skip_captcha (email, senha, soft_login)
        unless MOBILE
          request_consulta = RequestLogin.request_login(email, senha)
          response = realizar_login.post_login(request_consulta)
          page.driver.browser.manage.add_cookie(name: "sitecomercio", value: response["EfetuarLoginResult"]["Ticket"])
          url_atual = page.driver.browser.current_url
=begin
          # if MOBILE
          #   curr_url = Capybara.current_url
          #   orders_page = curr_url.slice(0..(curr_url.index('.com.br')))
          #   orders_page = orders_page + 'com.br/#/meus-pedidos/lista'
          #   go_to orders_page
          # else
=end
          click_el @@link_meus_pedidos
          sleep 6
          if page.driver.browser.current_url == url_atual
            sleep 6
          end
          puts 'Cookie:' + response["EfetuarLoginResult"]["Ticket"]
          if soft_login
            go_to url_atual, 5
          end
        end
      end

      def get_user usuario
        massa_cadastro = YAML.load_file('features/support/data/massa/cadastro.yml')
        user = usuario.to_s.gsub(/[\[\]\\\"]/, '')
        if MOBILE
          user_plat = 'email_mobile'
          senha_plat = 'senha_mobile'
        else
          user_plat = 'email'
          senha_plat = 'senha'
        end

        email_list = "#{massa_cadastro['login'][user][user_plat]}"
        email_list = email_list.split(",")
        $usuario_email = email_list[rand(0...email_list.length)]
        $usuario_senha = "#{massa_cadastro['login'][user][senha_plat]}"
      end

    end
  end
end