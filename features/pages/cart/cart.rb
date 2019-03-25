# Classe responsável por fazer as ações básicas na Tela Meu carrinho: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Cart < SitePrism::Page

      @@input_frete = 'cart.input_frete'
      @@check_garantia = 'cart.check_garantia'
      @@check_seguro = 'cart.check_seguro'
      @@massa_cadastro = YAML.load_file('features/support/data/massa/produto.yml')
      @@url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['carrinho']}"

      def acess_cart_page
        go_to @@url
      end

      def is_cart_page
        wait_spinner
        is_visible_el 'cart.title'
      end

      def click_concluir_compra
        wait_spinner
        is_visible_el 'cart.button_finish_payment'
        sleep 2
        click_el 'cart.button_finish_payment'
      end

      def check_right_warranty
        selected = get_text_el @@check_garantia
        warranty = ExtendedWarranty.new.selected_warranty
        if warranty != 'random'
          if selected.include? warranty
            tracing 'Garantia apresentada corretamente no carrinho'
            true
          else
            tracing_error "Atenção, a garantia selecionada anteriormente foi: #{warranty}, porém a mensagem apresentada
            no carrinho é: #{selected}"
            false
          end
        else
          true
        end
      end

      def check_cart_is_not_empty
        if is_visible_el 'cart.empty_cart'
          tracing_error 'Erro! Ao tentar efetuar login, o usuário foi direcionado para o carrinho vazio'
        end
      end

      def check_empty_cart
        is_visible_el 'cart.empty_cart'
      end

      def raise_product_quantity(sku_collection, qtd)
        is_visible_el 'cart.button_finish_payment'
        if qtd.to_i > 1
          send_keys_el_xpath(".//tr[@data-idsku='#{@@massa_cadastro['sku'][BANDEIRA][sku_collection]}']//descendant::input",
                             qtd)
          find_focus 'cart.button_buy_more_products'
        end

      end

      def remove_products
        click_el 'cart.link_remove' while is_visible_el 'cart.link_remove'
      end

      def wait_spinner
        unless MOBILE
          if is_visible_el 'cart.spinner'
            for i in 1..3 do
              if is_visible_el 'cart.title'
                break
              end
            end
          end
        end
      end

      def wedding_list_fill_pop_up from, message
        enter_frame 'cart.wedding_list_iframe'
        sleep 2 #todo Avaliar melhoria para sleep dentro de iframe
        is_visible_el 'cart.wedding_list_pop_up'
        send_keys_el('cart.wedding_list_pop_up_from', from)
        send_keys_el('cart.wedding_list_pop_up_message', message)
        click_el 'cart.wedding_list_pop_up_continue'
        exit_frame
      end
    end
  end
end