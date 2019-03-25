## Classe responsável por fazer as ações básicas no 'Modal Reitra Rápido': (GET, SET, CLICK) e validações
# encoding: utf-8
require 'rspec'
module Comercio
  module Home
    class ModalWithdrawFast < SitePrism::Page
      include RSpec::Matchers
      @@massa_produto = YAML.load_file('features/support/data/massa/produto.yml')

      def select_store_withdraw cep, withdraw_location
        enter_frame 'product_detail.tb_inframe_content'
        sleep 2
        page.find(:xpath, ".//input[@class='lupa-modal home']").click
        search_cep cep
        is_visible_el 'product_detail.modal_withdraw_div_modal_principal'
        select_withdraw_point withdraw_location
        exit_frame
      end

      def search_cep(cep)
        cep_value = "#{@@massa_produto['cep'][cep]}"
        send_keys_el 'product_detail.modal_withdraw_input_cep', cep_value
        click_el 'product_detail.modal_withdraw_magnifier'
        log_info 'Realizada busca com o CEP: ' + cep_value
      end

      def select_withdraw_point(type)
        sleep 2
        type = type.downcase
        if type.eql? 'random'
          select_random_location
        else
          case type
          when 'retira'
            select_withdraw_location
          when 'lockers'
            select_lockers_location
          when 'correios'
            select_post_offices_location
          when 'retira estoque loja'
            click_withdraw_2h
            select_withdraw_stock_store_location
          when 'retira estoque site'
            select_withdraw_stock_site_location
          else
            tracing_error "Erro! Local de retirada: #{type}  inválido. "
            +"Escolha entre 'retira', 'lockers', 'correio' ou 'random'"
          end
          click_withdraw_location
        end

      end

      def select_random_location
        click_el_random 'product_detail.modal_withdraw_div_establishment_random'
        tracing 'Selecionado local de retirada', true
      end

      def select_withdraw_location
        click_el_random 'product_detail.modal_withdraw_div_establishment_withdraw'
        tracing 'Selecionado local de retirada - Retira em loja', true
      end

      def select_lockers_location
        click_el_random 'product_detail.modal_withdraw_establishment_lockers'
        tracing 'Selecionado local de retirada - Lockers', true
      end

      def select_post_offices_location
        click_el_random 'product_detail.modal_withdraw_div_establishment_post_offices'
        tracing 'Selecionado local de retirada - Correios', true
      end

      def select_withdraw_stock_store_location
        #Aguardar o load do modal
        if is_visible_el 'product_detail.modal_loader_establishment'
          for i in 1..6 do
            if find_els_exists 'product_detail.modal_withdraw_establishment_withdraw_stock_store'
              click_el_random 'product_detail.modal_withdraw_establishment_withdraw_stock_store'
              break
            end
          end
        end
        tracing 'Selecionado local de retirada - Retira Estoque Loja', true
      end

      def select_withdraw_stock_site_location
        click_el_random 'product_detail.modal_withdraw_establishment_withdraw_stock_site'
        tracing 'Selecionado local de retirada - Retira Estoque Site', true
      end

      def click_withdraw_location
        click_el 'product_detail.modal_withdraw_button_withdraw_location'
      end

      def click_withdraw_2h
        click_el 'product_detail.modal_option_withdraw_2h'
      end
    end
  end
end