# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class PaymentDebitoOnline < SitePrism::Page
      @@button_fechar_modal = 'payment.debito_online_modal_debito_conta_button_fechar'
      @@modal_advertisement = 'payment.debito_online_modal_advertisement'

      def choose_debito_online forma_debito
        if forma_debito == 'random'
          click_el_random 'payment.debit_methods'
        else
          click_text_el 'payment.debit_methods', forma_debito
        end
      end

      def finish_payment_debito_online
        is_visible_el 'payment.debito_online_finish_payment'
        click_el 'payment.debito_online_finish_payment'
        enter_frame 'product_detail.tb_inframe_content'
        click_el @@button_fechar_modal if is_visible_el @@button_fechar_modal
        if (is_visible_el @@modal_advertisement)
          click_el @@modal_advertisement
        end
        exit_frame
      end
    end
  end
end
