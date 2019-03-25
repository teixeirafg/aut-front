# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class PaymentBoleto < SitePrism::Page

      def finish_payment_boleto
        sleep 2
        is_visible_el 'payment.boleto_finish_payment'
        if MOBILE
          click_el_random 'payment.boleto_finish_payment'
        else
          click_el 'payment.boleto_finish_payment'
        end
      end

    end
  end
end
