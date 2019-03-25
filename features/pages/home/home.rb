module Comercio
  module Home
    class Home < SitePrism::Page
      @@url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['home']}"
      @@links = YAML.load_file('features/support/data/config/links.yml')
      set_url @@url

      # load_validation {WaitPage.new}

      def open_menu
        left_menu_mobile.openLeftMenu
      end

      def login_access
        open_menu
        left_menu_mobile.openRegisterLogin
        if current_store.eql? 'pontofrio'
          unless MOBILE
            click_el 'home.hover_menu'
            click_el_script 'home.link_registrar'
          end
        else
          is_visible_el_desktop 'home.link_registrar'
          click_el_desktop 'home.link_registrar'
        end
      end

      def my_account_access
        open_menu
        left_menu_mobile.openMyAccount
      end


      def my_orders_access
        click_el 'home.my_orders_link'
      end

      def login_access_url
        url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['carrinho']}""#{@@links['login']}"
        go_to url
      end

      def access_validation
        $current_host = Capybara.current_host.to_s
        $ip_host = IPSocket::getaddress(@@url.gsub("http://", ""))
        tracing 'Acessado site: ' + $current_host
        tracing 'Ip Site: ' + $ip_host
        #screenshot(@@input_busca, 'Acessada tela home')
      end

      def is_home_page
        is_visible_el @@input_busca
      end


    end
  end
end

