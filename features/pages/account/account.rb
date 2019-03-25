# Classe responsável por fazer as ações básicas na Tela Endereco: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Account < SitePrism::Page

      def is_account_page
        is_visible_el 'account.title'
      end

      def access_user_data_mobile
        click_el 'account.access_user_data'
      end

      def change_password nova_senha
        if nova_senha.casecmp('default')
          nova_senha = 'Varejo12345678'
        end

        click_el 'account.change_password_option'
        send_keys_el 'account.current_password', $usuario_senha
        send_keys_el 'account.new_password', nova_senha
        send_keys_el 'account.confirm_new_password', nova_senha
        click_el 'account.save_changes_password'

        success_msg = is_visible_el 'account.success_message_password'
        success_msg
      end

      def change_email novo_email
        if novo_email.casecmp('random')
          novo_email = random_data novo_email, 'email'
        end

        if MOBILE
          result = change_email_mobile novo_email
        else
          result = change_email_desktop novo_email
        end
        result

      end


      def change_email_desktop novo_email
        click_el 'account.change_email_option'
        enter_frame 'account.change_email_frame'
        send_keys_el 'account.new_email', novo_email
        send_keys_el 'account.confirm_new_email', novo_email
        send_keys_el 'account.confirm_password_to_change_email', $usuario_senha
        click_el 'account.save_changes_email'

        success_msg = is_visible_el 'account.success_message_email'
        success_msg
        exit_frame

      end

      def change_email_mobile novo_email
        click_el 'account.change_user_data_option'
        send_keys_el 'account.current_email', novo_email
        send_keys_el 'account.confirm_new_email', novo_email
        click_el 'account.save_changes_user_data'

        success_msg = is_visible_el 'account.success_message_user_data'
        success_msg

      end


    end


  end
end