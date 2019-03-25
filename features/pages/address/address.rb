# Classe responsável por fazer as ações básicas na Tela Endereco: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Address < SitePrism::Page

      def choose_address endereco
        endereco = endereco.to_s.gsub(/[\[\]\\\"]/, '')

        close_frame

        unless is_visible_list_el 'address.select_endereco'
          wait_spinner
        end

        if endereco == 'random'
          if MOBILE
            select_random_el 'address.select_endereco'
          else
            select_random_el_not_first 'address.select_endereco'
          end
        elsif endereco == 'default'
          unless is_visible_el 'address.random_delivery'
            if MOBILE
              select_random_el 'address.select_endereco'
            else
              select_random_el_not_first 'address.select_endereco'
            end
          end
        else
          select_text_el 'address.select_endereco', endereco
        end
      end

      def wait_spinner
        if is_visible_el 'address.load_spinner'
          for i in 1..3 do
            sleep 3
            unless is_visible_el 'address.load_spinner'
              break
            end
          end
        end

      end


      def click_button_concluir
        WaitPage.new
        unless MOBILE
          is_retira_rapido
        end

        is_agendada

        wait_spinner
        if is_visible_el 'address.button_concluir'
          click_el 'address.button_concluir'
        end

        if MOBILE
          is_retira_rapido
        end
      end

      def is_agendada
        WaitPage.new
        if is_visible_el 'address.agendada_delivery_time'
          select_random_el_not_first 'address.agendada_delivery_time'
        end
      end


      def is_retira_rapido
        WaitPage.new
        if MOBILE
          click_el_random 'address.retira_rapido_choose_delivery'
        else
          if is_visible_el 'address.retira_rapido_delivery_estado'
            select_random_el_not_first 'address.retira_rapido_delivery_estado'
            select_random_el_not_first 'address.retira_rapido_delivery_regiao'
            select_random_el_not_first 'address.retira_rapido_delivery_cidade'
            select_random_el 'address.retira_rapido_delivery_bairro'
          end
        end

      end


      def choose_delivery delivery
        if delivery.casecmp('random')
          check_has_delivery 'address.random_delivery'
          wait_spinner
          click_el_random 'address.random_delivery'
        else
          case delivery.downcase
          when 'expressa'
            element = 'address.expressa_delivery'
          when 'normal'
            element = 'address.normal_delivery'
          when 'agendada'
            element = 'address.agendada_delivery'
          when 'mesmo_dia'
            element = 'address.mesmo_dia_delivery'
          when 'super_expressa'
            element = 'address.super_expressa_delivery'
          when 'retira_rapido'
            element = 'address.retira_rapido_delivery'
          else
            msg = "Atenção, o tipo de entrega #{delivery} é inválido, seleciona alguma das opções a seguir: 'Expressa', 'Normal', 'Agendada',
            'Mesmo_dia', 'Super_expressa' ou 'Retira_rapido'"
            tracing_error msg
          end

          check_has_delivery element
          wait_spinner
          click_el element

          log_info "Selecionado tipo de entrega: '#{delivery}'"
          true
        end
      end


      def check_has_delivery delivery_type
        if is_visible_el delivery_type
          true
        else
          addresses = find_all_els 'address.select_endereco'
          addresses.each do |x|
            click_solved_el x
            sleep 4
            if is_visible_el delivery_type
              break
            end
          end

        end


      end


      def close_frame
        if MOBILE
          if current_store.casecmp 'extra'
            is_frame_on = enter_frame_mobile 'address.social_miner'
            unless is_frame_on
              sleep 6
              enter_frame_mobile 'address.social_miner'
            end

            if is_visible_el 'address.frame_close'
              click_el_script 'address.frame_close'
            end
            exit_frame_mobile
          end
        end
      end

      #Se aplica somente para locker e correio
      def fill_in_cell_phone
        cel_phone = Faker::PhoneNumber.numerify('119########')
        send_keys_el 'address.input_cell_phone', cel_phone, true
      end


    end
  end
end