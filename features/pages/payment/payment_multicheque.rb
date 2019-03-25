# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class PaymentMultiCheque < SitePrism::Page

      @card_num = ''
      @card_cvv = ''
      @card_name = ''
      def fill_multicheque
        load_multi_cheque_file

        send_keys_el 'payment.multicheque_card_number', @card_num
        select_random_el 'payment.multicheque_month'
        select_random_el 'payment.multicheque_year'
        send_keys_el 'payment.multicheque_name', @card_name
        send_keys_el 'payment.multicheque_cvv', @card_cvv
      end

      def finish_payment_multicheque
        is_visible_el 'payment.multicheque_finish_payment'
        click_el 'payment.multicheque_finish_payment'
      end

      def load_multi_cheque_file
        begin
          card_file = YAML.load_file('features/support/data/massa/pagamento.yml')
          card = "#{card_file['cartao_de_credito']['multicheque']['numero']}"
          card = card.split(",")
          card = card[rand(0...card.length)]
          @card_num = card
          @card_cvv = "#{card_file['cartao_de_credito']['multicheque']['cvv']}"
          @card_name = "#{card_file['cartao_de_credito']['multicheque']['nome']}"
        rescue StandardError
          msg = 'Erro ao carregar o arquivo YML de multicheque'
          tracing_error msg
          raise msg
        end
      end

    end
  end
end
