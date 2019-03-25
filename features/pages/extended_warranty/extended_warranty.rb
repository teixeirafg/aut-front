# Classe responsável por fazer as ações básicas na Tela de garantia estendida como: (GET, SET, CLICK) e validações
# encoding: utf-8

module Comercio
  module Home
    class ExtendedWarranty < SitePrism::Page

      attr_reader :selected_warranty
      attr_reader :selected_insurance
      attr_reader :price_warranty
      attr_reader :price_insurance

      def is_extended_warranty_page
        is_visible_el 'extended_warranty.title'
      end

      def click_continue
        WaitPage.new
        sleep 4
        if is_extended_warranty_page
          if is_visible_el 'extended_warranty.spinning_block'
            sleep 4
          end
          click_el_random 'extended_warranty.button_continuar'
        end

      end

      def has_warranty
        is_visible_list_el 'extended_warranty.select_random_garantia'
      end

      def has_insurance
        is_visible_list_el 'extended_warranty.select_random_seguro'
      end

      def select_warranty_and_insurance(warranty, inssurance)
        select_warranty(warranty)
        select_insurance(inssurance)

      end

      def select_warranty (meses)
        @selected_warranty = meses
        if meses == 'random'
          if MOBILE
            click_el_random 'extended_warranty.change_garantia'
            click_el 'extended_warranty.select_random_garantia'
          else
            click_el_random 'extended_warranty.select_random_garantia'
          end
        else
          case meses
          when ''
            el_warranty = ''
          when '12'
            el_warranty = 'extended_warranty.select_garantia_12_meses'
          when '24'
            el_warranty = 'extended_warranty.select_garantia_24_meses'
          when '36'
            el_warranty = 'extended_warranty.select_garantia_32_meses'
          else
            tracing_error "Erro! Garantia de #{meses} meses é inválida. Escolha entre '12', '24', '36' ou 'random'"
          end
          unless el_warranty.empty?
            if MOBILE
              select_warranty_mobile el_warranty
            end

            click_el el_warranty
            tracing "Seleciona a garantia estendida de #{meses} meses"
          end
          # keep_price el_warranty, 'warranty'
        end
      end

      def select_warranty_mobile (element)
        warranty = find_all_els 'extended_warranty.change_garantia'
        warranty.each do |x|
          click_solved_el x
          if is_visible_el element
            true
          end
        end

      end

      def select_insurance (seguro)
        @selected_insurance = seguro
        if seguro == 'random'
          if MOBILE
            click_el_random 'extended_warranty.change_seguro'
            click_el 'extended_warranty.select_random_seguro'
          else
            click_el_random 'extended_warranty.select_random_seguro'
          end
        else
          case seguro
          when ''
            el_keep_safe = ''
          when 'roubo'
            el_keep_safe = 'extended_warranty.select_seguro_roubo'
          when 'quebra'
            el_keep_safe = 'extended_warranty.select_seguro_quebra'
          when 'roubo_e_quebra'
            el_keep_safe = 'extended_warranty.select_seguro_roubo_e_quebra'
          else
            tracing_error "Erro! Seguro do tipo #{seguro} é inválido. Escolha entre 'roubo', 'quebra', 'roubo_e_quebra' ou 'random'"
          end
          unless el_keep_safe.empty?
            if MOBILE
              select_insurance_mobile el_keep_safe
            end

            click_el el_keep_safe
            tracing "Selecionado seguro de #{seguro}"
          end
        end
      end

      def select_insurance_mobile (element)
        warranty = find_all_els 'extended_warranty.change_seguro'
        warranty.each do |x|
          click_solved_el x
          if is_visible_el element
            true
          end
        end

      end

      def keep_price el, price_name
        el = find_child_el el, 'extended_warranty.total_price'
        if price_name == 'insurance'
          @price_insurance = el.text
        else
          @price_warranty = el.text
        end
      end
    end
  end
end