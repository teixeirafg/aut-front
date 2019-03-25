Dado('que estou na tela de lista de casamento como convidado do site da bandeira --WeddingListPage') do
  @wedding_list = wedding_list
  @wedding_list.load
  @wedding_list.loaded?
  @wedding_list.access_validation
  @wedding_list.click_logo
  tracing 'Acessando a lista de casamento como convidado', true
end

Dado('que realizo busca por nome dos noivos {string} --WeddingListPage') do |noivos|
  wedding_list.input_engaged_name noivos
  wedding_list.button_engaged_list
  expecting(wedding_list.is_engaged_list, true, 'Checa se lista de casamento foi encontrada')
end

Dado('seleciono produto na lista de desejos --WeddingListPage') do
  wedding_list.select_random_option_from_grid_engaged_list
  expecting(wedding_list.is_gift_list, true, 'Checa se há presentes disponíveis')
  wedding_list.select_random_option_from_grid_gift_list
  tracing 'Selecionando produto na lista de desejos', true

end

Quando('movo produto para o carrinho enviando mensagem aos noivos --WeddingListPage') do
  cart.is_cart_page
  cart.click_concluir_compra
  cart.wedding_list_fill_pop_up 'Automação', 'Teste automatizado'
  tracing 'Movendo produto para o carrinho e enviando mensagem aos noivos', true

end

Então('finalizo a compra pelo fluxo de lista de casamentos -WeddingListPage') do |table|
  table.hashes.each do |row|
    address.click_button_concluir
    payment.choose_payment_method 'credito'
    payment.payment_with_one_card row[:bandeira_cartao], row[:qty_parcelas]
  end
  step 'confirmo que o número do pedido foi apresentado --FinishedPayment'
end
