# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class FinishedPayment < SitePrism::Page

      @@numero_pedido = 'finished_payment.numero_pedido'

      def get_numero_pedido
        close_ebit_modal
        unless is_visible_el 'finished_payment.numero_pedido'
          sleep 4
        end
        num_pedido = find_el 'finished_payment.numero_pedido'
        pedido = num_pedido.text
        tracing "Pedido realizado com sucesso. Número do pedido: #{pedido}", true
        pedido
      end

      def close_ebit_modal
        if MOBILE
          if is_visible_el 'finished_payment.close_ebit_modal'
            click_el_script 'finished_payment.close_ebit_modal'
          end
        end
      end

      def go_to_order_detail
        if is_visible_el 'finished_payment.go_to_orders'
          click_el_script 'finished_payment.go_to_orders'
        else
          click_el_script 'finished_payment.go_to_orders_link'
        end
      end

      def close_debit_payment_modal
        if is_visible_el 'finished_payment.close_debit_payment_modal'
          click_el_script 'finished_payment.close_debit_payment_modal'
        end
      end
    end
  end
end