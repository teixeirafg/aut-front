# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Payment < SitePrism::Page

      def is_payment_page
        is_visible_el 'payment.title_pagamento'
      end

      def choose_payment_method(forma_pagamento)
        #aguardando o site, pois ele seleciona sozinho a opção de boleto, e as vezes isso causa falhas

        case forma_pagamento.downcase
        when 'credito'
          element = 'payment.choose_credit_method'
        when 'boleto'
          element = 'payment.choose_boleto_method'
        when 'debito'
          element = 'payment.choose_debit_method'
        when 'paypal'
          element = 'payment.choose_paypal_method'
        when 'multichque'
          element = 'payment.choose_multicheque_method'
        when 'giftcard'
          element = 'payment.choose_giftcard_method'
        when 'visa_checkout'
          element = 'payment.choose_visa_checkout_method'
        when 'masterpass'
          element = 'payment.choose_master_pass_method'
        else
          tracing_error "Atenção, o método de pagamento #{forma_pagamento} não é válido. Selecione uma das opções a seguir:
          'credito', 'boleto', 'debit', 'paypal', 'multichque', 'giftcard', 'visa_checkout' ou 'masterpass'"
        end

        wait_spinner
        click_el element
        wait_spinner

        tracing "Selecionada forma de pagamento: #{forma_pagamento}", true
      end

      def payment_with_one_card card, installments
        #payment_credit_card.choose_credit_card_with_one_card_mobile
        payment_credit_card.fill_single_card card, installments
        payment_credit_card.keep_single_card_data
        payment_credit_card.finish_payment_credit_card
      end

      def payment_with_two_cards card1, installments1, card2, installments2
        payment_credit_card.choose_credit_card_with_two_cards
        payment_credit_card.fill_first_card card1, installments1
        payment_credit_card.keep_first_card_data
        payment_credit_card.fill_second_card card2, installments2
        payment_credit_card.keep_second_card_data

        payment_credit_card.finish_payment_credit_card
      end

      def payment_with_multicheque card
        payment_multi_cheque.fill_multicheque card
        payment_multi_cheque.finish_payment_multicheque
      end


      def payment_with_two_cards_change_values card1, installments1, value1, card2, installments2, value2
        if value1.casecmp('no') && value2.casecmp('no')
          tracing_error 'Atenção, nenhum valor de alteração foi passado, tornando o cenário inválido'
        elsif !value1.casecmp('no') && !value2.casecmp('no')
          tracing_error 'Atenção, apenas um campo de valor deve ser alterado'
        elsif !value1.casecmp('no')
          value_to_change = value1
          option = 'first_card'
        else
          value_to_change = value2
          option = 'second_card'
        end

        payment_credit_card.choose_credit_card_with_two_cards
        payment_credit_card.fill_single_card card1, installments1
        payment_credit_card.fill_second_card card2, installments2
        payment_credit_card.change_value option, value_to_change
        payment_credit_card.finish_payment_credit_card
      end


      def payment_with_one_card_and_boleto card, installments
        payment_credit_card.choose_credit_card_with_boleto
        payment_credit_card.fill_single_card card, installments
        payment_credit_card.finish_payment_credit_card
      end

      def payment_with_one_card_and_boleto_changing_values card, installments, value1, value2
        if value1.casecmp('no') && value2.casecmp('no')
          tracing_error 'Atenção, nenhum valor de alteração foi passado, tornando o cenário inválido'
        elsif !value1.casecmp('no') && !value2.casecmp('no')
          tracing_error 'Atenção, apenas um campo de valor deve ser alterado'
        elsif !value1.casecmp('no')
          value_to_change = value1
          option = 'first_card'
        else
          value_to_change = value2
          option = 'second_card'
        end
        payment_credit_card.choose_credit_card_with_boleto
        payment_credit_card.change_value option, value_to_change
        payment_credit_card.fill_single_card card, installments
        payment_credit_card.finish_payment_credit_card
      end

      def payment_with_debito_online forma_debito
        payment_debito_online.choose_debito_online forma_debito
        payment_debito_online.finish_payment_debito_online
      end

      def payment_with_boleto
        payment_boleto.finish_payment_boleto
      end


      def wait_spinner
        unless MOBILE
          if is_visible_el 'payment.load_spinner'
            for i in 1..3 do
              sleep 1
              unless is_visible_el 'payment.load_spinner'
                break
              end
            end
          end
        end
      end

    end
  end
end
