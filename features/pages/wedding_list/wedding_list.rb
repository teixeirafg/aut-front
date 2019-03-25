module Comercio
  module Home
    class WeddingList < SitePrism::Page
      @@url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['lista_casamento']}"
      @@links = YAML.load_file('features/support/data/config/links.yml')
      set_url @@url

      def access_validation
        $current_host = Capybara.current_host.to_s
        $ip_host = IPSocket::getaddress(@@url.gsub("https://", ""))
        tracing 'Acessado site: ' + $current_host
        tracing 'Ip Site: ' + $ip_host
      end

      def click_logo
        click_el 'wedding_list.img_logo'
      end

      def input_engaged_name engaged
        send_keys_el 'wedding_list.input_engaged', engaged
      end

      def button_engaged_list
        click_el 'wedding_list.button_engaged_list'
      end

      def is_engaged_list
        is_visible_el 'wedding_list.div_grid_engaged_list'
      end

      def is_gift_list
        is_visible_el 'wedding_list.div_grid_gift_list'
      end

      def select_random_option_from_grid_engaged_list
        find_all_els('wedding_list.div_grid_engaged_list_options').sample.click
      end

      def select_random_option_from_grid_gift_list
        find_all_els('wedding_list.div_grid_gift_list_options').sample.click
      end
    end
  end
end
