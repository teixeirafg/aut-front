# Classe responsável por fazer as ações básicas na Tela do logista: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class Logist < SitePrism::Page
      def click_button_withdraw
        click_el 'logist.button_withdraw_cb'
      end
    end
  end
end