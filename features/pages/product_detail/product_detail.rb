# Classe responsável por fazer as ações básicas na Tela de detalhe do produto: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class ProductDetail < SitePrism::Page
      def click_buy
        is_visible_el 'product_detail.button_comprar'
        click_el 'product_detail.button_comprar'
        accept_alert_if_displayed

      end

      def search_sku sku, db=false
        go_to random_sku sku, db
      end

      def is_product_page
        is_visible_el 'product_detail.title'
      end

      def click_withdraw_fast
        click_el 'product_detail.button_retira'
      end

      def click_more_options
        click_el 'product_detail.link_more_options'
      end
    end
  end
end



