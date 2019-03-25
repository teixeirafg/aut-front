module Comercio
  module Home
    class SectionLeftMenuMobile < SitePrism::Section

      def initialize
      end

      def openLeftMenu
        click_el_mobile 'section_main_menu_mobile.mobile_a_dashboard'
      end

      def openRegisterLogin
        is_visible_el_mobile 'section_main_menu_mobile.div_profile_login'
        click_el_mobile 'section_main_menu_mobile.div_profile_login'
      end

      def openMyAccount
        is_visible_el_mobile 'section_main_menu_mobile.my_account'
        click_el_mobile 'section_main_menu_mobile.my_account'
      end
    end
  end
end
