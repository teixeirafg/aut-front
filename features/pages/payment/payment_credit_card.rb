# Classe responsável por fazer as ações básicas na Tela Pagamento: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class PaymentCreditCard < SitePrism::Page

      @@cards = []
      @card_num
      @card_cvv
      @card_name

      def generate_card_info card
        card_file = load_card_file

        if card.casecmp('random')
          @@cards = ["visa", "master", "american_express", "diners", "elo"]
          card = @@cards.shuffle.first
          @@cards.delete(card)
        end

        begin
          card_temp = "#{card_file['cartao_de_credito'][card]['numero']}"
          card_temp = card_temp.split(",")
          card_temp = card_temp[rand(0...card_temp.length)]
          @card_num = card_temp
          @card_cvv = "#{card_file['cartao_de_credito'][card]['cvv']}"
          @card_name = "#{card_file['cartao_de_credito'][card]['nome']}"
        rescue StandardError
          msg = 'Erro ao carregar as propriedades dentro do arquivo YML referente ao cartão de crédito'
          tracing_error msg
          raise msg
        end
      end

      def load_card_file
        begin
          card_file = YAML.load_file('features/support/data/massa/pagamento.yml')
        rescue StandardError
          msg = 'Erro ao carregar o arquivo YML referente ao cartão de crédito'
          tracing_error msg
          raise msg
        end
        card_file
      end

      def fill_single_card card, installments
        generate_card_info card
        is_visible_el 'payment.credit_card_number'
        send_keys_el 'payment.credit_card_number', @card_num
        fill_single_card_expiration_date
        send_keys_el 'payment.credit_card_name', @card_name
        send_keys_el 'payment.credit_card_cvv', @card_cvv
        fill_single_card_installments installments
      end


      def fill_single_card_expiration_date
        if MOBILE
          send_keys_el 'payment.expiration_date', '02/2020'
        else
          click_el 'payment.credit_card_year'
          select_random_el_not_first 'payment.credit_card_year_options'
          click_el 'payment.credit_card_month'
          select_random_el_not_first 'payment.credit_card_month_options'
        end
      end

      def fill_single_card_installments installments
        if MOBILE
          select_random_el 'payment.credit_card_installments_list_option'
        else
          if installments.casecmp('random')
            installments = rand(1...12)
          end
          send_keys_el 'payment.credit_card_installments_box', installments
          click_el 'payment.credit_card_installments_list'
        end
      end

      #PAYMENT WITH TWO CARDS
      def fill_first_card card, installments
        generate_card_info card
        is_visible_el 'payment.credit_card_one_number'
        send_keys_el 'payment.credit_card_one_number', @card_num
        fill_first_card_expiration_date
        send_keys_el 'payment.credit_card_one_name', @card_name
        send_keys_el 'payment.credit_card_one_cvv', @card_cvv
        fill_first_card_installments installments
      end


      def fill_first_card_expiration_date
        if MOBILE
          send_keys_el 'payment.credit_card_one_expiration_date', '02/2020'
        else
          click_el 'payment.credit_card_one_year'
          select_random_el_not_first 'payment.credit_card_one_year_options'
          click_el 'payment.credit_card_one_month'
          select_random_el_not_first 'payment.credit_card_one_month_options'
        end
      end

      def fill_first_card_installments installments
        if MOBILE
          select_random_el_not_first 'payment.credit_card_one_installments_list_option'
        else
          if installments.casecmp('random')
            installments = rand(1...12)
          end
#          select_random_el_not_first 'payment.credit_card_one_installments_list_option'
          send_keys_el 'payment.credit_card_one_installments_box', installments
          click_el 'payment.credit_card_one_installments_list'
        end
      end

      def fill_second_card card, installments
        generate_card_info card

        send_keys_el 'payment.credit_card_two_number', @card_num
        fill_second_card_expiration_date
        send_keys_el 'payment.credit_card_two_name', @card_name
        send_keys_el 'payment.credit_card_two_cvv', @card_cvv
        fill_second_card_installments installments

      end

      def fill_second_card_expiration_date
        if MOBILE
          send_keys_el 'payment.credit_card_two_expiration_date', '02/2020'
        else
          click_el 'payment.credit_card_two_year'
          select_random_el_not_first 'payment.credit_card_two_year_options'
          click_el 'payment.credit_card_two_month'
          select_random_el_not_first 'payment.credit_card_two_month_options'
        end
      end

      def fill_second_card_installments installments
        if MOBILE
          select_random_el_not_first 'payment.credit_card_two_installments_list'
        else
          if installments.casecmp('random')
            installments = rand(1...12)
          end
#          select_random_el_not_first 'payment.credit_card_two_installments_list'
          send_keys_el 'payment.credit_card_two_installments_box', installments
          click_el 'payment.credit_card_two_installments_list'

          if current_store.downcase == 'barateiro'
            select_random_el_not_first 'payment.credit_card_installments_list_option'
          end

        end
      end

      def change_value option, new_value
        case option
        when 'boleto'
          element = 'payment.credit_card_boleto_value'
        when 'first_card'
          element = 'payment.credit_card_one_value'
        when 'second_card'
          element = 'payment.credit_card_two_value'
        else
          tracing_error "A opção de alteração de campo #{option} não existe. Selecionar 'boleto', 'first-card', 'second-card'"
        end
        clear_send_keys_el element, new_value
      end

      def choose_credit_card_with_one_card_mobile
        click_el_mobile 'payment.credit_card_choose_credit_card'
      end

      def choose_credit_card_with_two_cards
        click_el_mobile 'payment.open_payment_options_mobile'
        click_el 'payment.credit_card_choose_two_credit_cards'
      end

      def choose_credit_card_with_boleto
        click_el_mobile 'payment.open_payment_options_mobile'
        click_el 'payment.credit_card_choose_credit_card_and_boleto'
      end

      def keep_single_card_data
        if is_visible_el 'payment.credit_card_keep_data'
          click_el 'payment.credit_card_keep_data'
        end
      end

      def keep_first_card_data
        if is_visible_el 'payment.credit_card_one_keep_data'
          click_el 'payment.credit_card_one_keep_data'
        end
      end

      def keep_second_card_data
        if is_visible_el 'payment.credit_card_two_keep_data'
          click_el 'payment.credit_card_two_keep_data'
        end
      end

      def finish_payment_credit_card
        sleep 2
        is_visible_el 'payment.credit_card_finish_payment'
        if MOBILE
          click_el_random 'payment.credit_card_finish_payment'
        else
          click_el 'payment.credit_card_finish_payment'
        end
      end


    end
  end
end
