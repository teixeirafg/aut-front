#encoding: utf-8
Dado('seleciono o endereço {string} --AddressPage') do |addressType|
  address.choose_address addressType
end

Dado('seleciono o tipo de entrega {string} --AddressPage') do |deliveryType|
  address.choose_delivery deliveryType
end

Dado('movo o produto para a página de pagamento --AddressPage') do
  address.click_button_concluir
  unless payment.is_payment_page
    address.click_button_concluir
  end
  expecting(payment.is_payment_page, true, 'Verifica que foi direcionado para a tela de pagamento')
end

Quando('confirmo o numero de celular para receber isntruções por SMS --AddressPage') do
  address.fill_in_cell_phone
end
