# Classe responsável por fazer as ações básicas na Tela Meus Pedidos: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Orders < SitePrism::Page

      def acess_page_orders
        url = "#{DOMINIO[ENV['BANDEIRA']][ENV['AMBIENTE']]['carrinho']}" + '/Site/MeusPedidos.aspx'
        go_to url

        unless is_visible_el 'orders.title_meus_pedidos'
          sleep 2
        end
        is_visible_el 'orders.title_meus_pedidos'
      end

      def check_order numero_pedido
        order = find_el 'orders.detail_order_number'
        unless order.text.casecmp numero_pedido
          tracing_error "Numero do pedido: #{numero_pedido} não confere com o pedido apresentado #{order.text}"
        end
        true
      end

      def search_order (numero_pedido)
        set_numero_pedido(numero_pedido)
        click_button_buscar
        if !is_visible_el 'orders.table_pedidos'
          sleep 4
        end
        find_el 'orders.table_pedidos'
        table_pedido = find_el 'orders.td_numero_pedido'
        unless table_pedido.text.eql? numero_pedido
          tracing_error "Numero do pedido: #{numero_pedido} não encontrado"
        end
        click_el 'orders.td_numero_pedido'
        true
      end

      def check_quantity_product(quantity)
        qtd = find_el 'orders.detail_order_td_qtd'
        qtd = qtd.text.gsub(/\s+/, '')
        unless qtd.eql? quantity
          tracing_error "Quantidade do produto: #{quantity} diferente do esperado"
        end
        true
      end

      def set_numero_pedido(numero_pedido)
        send_keys_el 'orders.input_numero_pedido', numero_pedido
      end

      def click_button_buscar
        click_el 'orders.button_buscar'
      end

      def access_my_profile_tab
        click_el 'orders.my_profile_tab'
      end

    end
  end
end
