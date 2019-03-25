module Comercio
  def left_menu_mobile
    Comercio::Home::SectionLeftMenuMobile.new
  end

  def home
    Comercio::Home::Home.new
  end

  def product_detail
    Comercio::Home::ProductDetail.new
  end

  def extended_warranty
    Comercio::Home::ExtendedWarranty.new
  end

  def account
    Comercio::Home::Account.new
  end

  def register
    Comercio::Home::Register.new
  end

  def login
    Comercio::Home::Login.new
  end

  def address
    Comercio::Home::Address.new
  end

  def cart
    Comercio::Home::Cart.new
  end

  def payment
    Comercio::Home::Payment.new
  end

  def payment_credit_card
    Comercio::Home::PaymentCreditCard.new
  end

  def payment_boleto
    Comercio::Home::PaymentBoleto.new
  end

  def payment_debito_online
    Comercio::Home::PaymentDebitoOnline.new
  end

  def payment_multi_cheque
    Comercio::Home::PaymentMultiCheque.new
  end

  def finished_payment
    Comercio::Home::FinishedPayment.new
  end

  def orders
    Comercio::Home::Orders.new
  end

  def modal_withdraw_fast
    Comercio::Home::ModalWithdrawFast.new
  end

  def logist
    Comercio::Home::Logist.new
  end

  def wedding_list
    Comercio::Home::WeddingList.new
  end
end
