# Classe responsável por fazer as ações básicas na Tela de Identificacao: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Register < SitePrism::Page

      def fill_pf_data(name, cpf, day, month, year, sex)
        send_keys_el 'register.full_name', random_data(name, 'full_name')
        send_keys_el 'register.cpf', random_data(cpf, 'cpf')
        send_keys_el 'register.day_born', random_data(day, 'day')
        send_keys_el 'register.month_born', random_data(month, 'month')
        send_keys_el 'register.year_born', '1986'
        choose_pf_sex sex
      end

      def fill_pf_data_mobile(name, cpf, birth, sex)
        send_keys_el 'register.full_name', random_data(name, 'full_name')
        send_keys_el 'register.cpf', random_data(cpf, 'cpf')

        send_keys_el 'register.birth', '02/10/1986'
        tracing 'Preenche data de aniversário', true
        choose_pf_sex sex
      end

      def choose_pf_sex sex
        sex_list = %w(register.sex_male register.sex_female)
        if sex.casecmp('male')
          click_el sex_list[0]
        elsif sex.casecmp('female')
          click_el sex_list[1]
        else
          click_el sex_list.shuffle.first
        end
      end

      def fill_pf_phones(phone1_ddd, phone1_number, phone2_ddd, phone2_number)
        send_keys_el 'register.phone1_ddd', random_data(phone1_ddd, 'ddd')
        send_keys_el 'register.phone1_number', random_data(phone1_number, 'phone_number')
        send_keys_el 'register.phone2_ddd', random_data(phone2_ddd, 'ddd')
        send_keys_el 'register.phone2_number', random_data(phone2_number, 'phone_number')
      end

      def fill_phone_mobile(phone)
        send_keys_el_mobile 'register.cellphone', random_data(phone, 'ddd') + random_data(phone, 'phone_number')
      end

      def choose_pj
        WaitPage.new
        click_el 'register.choosePJ'
      end

      def fill_pj_data social_name, fantasy_name, cnpj, site, state_inscription, exempt_inscription, simples
        send_keys_el 'register.social_name', random_data(social_name, 'full_name')
        send_keys_el 'register.fantasy_name', random_data(fantasy_name, 'full_name')
        send_keys_el 'register.cnpj', random_data(cnpj, 'cnpj')
        select_random_el_desktop 'register.state_pj'
        scroll_page_down
        send_keys_el 'register.state_inscription', random_data(state_inscription, 'phone_number')
        send_keys_el 'register.pj_site', random_data(site, 'site')
        if exempt_inscription
          click_el 'register.no_state_inscription'
        end
        if simples
          click_el 'register.simples_option'
        end

      end

      def fill_pj_phones(pj_ddd_1, pj_phone_1, pj_ddd_2, pj_phone_2)
        send_keys_el 'register.phone1_pj_ddd', random_data(pj_ddd_1, 'ddd')
        send_keys_el 'register.phone1_pj_number', random_data(pj_phone_1, 'phone_number')
        send_keys_el 'register.phone2_pj_ddd', random_data(pj_ddd_2, 'ddd')
        send_keys_el 'register.phone2_pj_number', random_data(pj_phone_2, 'phone_number')
      end

      def fill_log_in_info(email, password)
        final_email = random_data(email, 'email')
        send_keys_el 'register.email', final_email
        send_keys_el 'register.email_confirmation', final_email
        send_keys_el 'register.password', password
        send_keys_el 'register.password_confirmation', password
      end

      def choose_notifications(notifications)
        if notifications
          click_el 'register.get_email_notification'
          click_el 'register.get_sms_notification'
        end
      end

      def finish_registration
        click_el_script 'register.finish_registration'
      end

    end
  end
end