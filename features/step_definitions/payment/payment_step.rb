#encoding: utf-8
#

Quando('finalizo a compra com a opção de débito online para {string} --PaymentPage') do |option|
  payment.choose_payment_method 'debito'
  payment.payment_with_debito_online option
  finished_payment.close_debit_payment_modal
end

Quando('finalizo a compra com a opção de cartão de crédito para a bandeira {string} e {string} parcelas --PaymentPage') do |card_brand, installments|
  payment.choose_payment_method 'credito'
  payment.payment_with_one_card card_brand, installments
end

Quando('finalizo a compra com dois cartões de crédito para a bandeira {string} e {string} parcelas e para a bandeira {string} e {string} parcelas --PaymentPage') do |card_brand, installments, card_brand2, installments2|
  payment.choose_payment_method 'credito'
  payment.payment_with_two_cards card_brand, installments, card_brand2, installments2
end

Quando('finalizo a compra com dois cartões de crédito para a bandeira {string}, {string} parcelas e alterando o valor para {string}, e para a bandeira {string}, {string} parcelas e alterando o valor para {string} --PaymentPage') do |card_brand, installments, value, card_brand2, installments2, value2|
  payment.choose_payment_method 'credito'
  payment.payment_with_two_cards_change_values card_brand, installments, value, card_brand2, installments2, value2
end

Quando('finalizo a compra com a opção de cartão de crédito para a bandeira {string} e {string} parcelas e boleto --PaymentPage') do |card_brand, installments|
  payment.choose_payment_method 'credito'
  payment.payment_with_one_card_and_boleto card_brand, installments
end

Quando('finalizo a compra com a opção de cartão de crédito para a bandeira {string}, {string} parcelas e alterando o valor para {string} e boleto alterando o valor para {string} --PaymentPage') do |card_brand, installments, value, value2|
  payment.choose_payment_method 'credito'
  payment.payment_with_one_card_and_boleto_changing_values card_brand, installments, value, value2
end

Quando('finalizo a compra com a opção de boleto --PaymentPage') do
  payment.choose_payment_method 'boleto'
  payment.payment_with_boleto
end

Quando('finalizo a compra com a opção de multicheque para a bandeira {string} --PaymentPage') do |bandeira|
  payment.choose_payment_method 'multicheque'
  payment.payment_with_multicheque bandeira
end

Quando("levo um produto até a página de pagamento com um novo usuário via api --PaymentPage") do |table|
  table.hashes.each do |row|
    step "estou logado com um novo usuário criado via API --LoginPage"
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step "seleciono o tipo de entrega '#{row[:tipo_entrega]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando('levo um produto selecionando garantia e seguro até a página de pagamento fazendo login --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'verifico que estou na página de garantia estendida --ExtendedWarrantyPage'
    step "escolho minha opção de garantia estendida '#{row[:garantiaEstendida]}' --ExtendedWarrantyPage"
    step "escolho minha opção de seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "faço o login com meu usuário parametrizado '#{row[:usuario]}' --LoginPage"
    step 'verifico que o carrinho não está vazio --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end


Quando ('levo um produto normal até a página de pagamento já logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step "escolho minhas opções de garantia estendida '#{row[:garantiaEstendida]}' e seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step "movo o produto para o carrinho --ExtendedWarrantyPage"
    step "aumento a quantidade do produto '#{row[:sku]}' para '#{row[:quantidade]}' --CartPage"
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step "seleciono o tipo de entrega '#{row[:opção_de_entrega]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end


Quando('levo um produto selecionando garantia e seguro até a página de pagamento já logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'verifico que estou na página de garantia estendida --ExtendedWarrantyPage'
    step "escolho minha opção de garantia estendida '#{row[:garantiaEstendida]}' --ExtendedWarrantyPage"
    step "escolho minha opção de seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando('levo um produto selecionando apenas garantia até a página de pagamento já logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'verifico que estou na página de garantia estendida --ExtendedWarrantyPage'
    step "escolho minha opção de garantia estendida '#{row[:garantiaEstendida]}' --ExtendedWarrantyPage"
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando('levo um produto até a página de pagamento fazendo login --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "faço o login com meu usuário parametrizado '#{row[:usuario]}' --LoginPage"
    step 'verifico que o carrinho não está vazio --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step "seleciono o tipo de entrega '#{'random'}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando('levo um produto até a página de pagamento já logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step "seleciono o tipo de entrega '#{row[:tipo_entrega]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end


Quando("levo um produto retira até a página de pagamento já logado --PaymentPage") do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step "Clico em retira rápido --ProductDetailPage"
    step "Seleciono uma loja para retirada com o cep '#{row[:cep]}' e local de retirada '#{row[:ponto_retirada]}' --ProductDetailPage"
    step "escolho minhas opções de garantia estendida '#{row[:garantiaEstendida]}' e seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step "movo o produto para o carrinho --ExtendedWarrantyPage"
    step "aumento a quantidade do produto '#{row[:sku]}' para '#{row[:quantidade]}' --CartPage"
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    if row[:ponto_retirada].eql? 'lockers' or row[:ponto_retirada].eql? 'correios'
      step "confirmo o numero de celular para receber isntruções por SMS --AddressPage"
    end
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando("levo um produto retira logista até a página de pagamento já logado --PaymentPage") do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'sou redirecionado para a página do logista'
    step 'clico no botão Retirar na pagina do logista'
    step "Seleciono uma loja para retirada com o cep '#{row[:cep]}' e local de retirada '#{row[:ponto_retirada]}' --ProductDetailPage"
    step "escolho minhas opções de garantia estendida '#{row[:garantiaEstendida]}' e seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step "movo o produto para o carrinho --ExtendedWarrantyPage"
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    if row[:ponto_retirada].downcase.eql? 'lockers' or row[:ponto_retirada].downcase.eql? 'correios'
      step "confirmo o numero de celular para receber isntruções por SMS --AddressPage"
    end
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando("levo dois produtos normais até a página de pagamento já logado --PaymentPage") do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step "escolho minhas opções de garantia estendida '#{row[:garantiaEstendida]}' e seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step "movo o produto para o carrinho --ExtendedWarrantyPage"
    step "aumento a quantidade do produto '#{row[:sku]}' para '#{row[:quantidade]}' --CartPage"
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step "escolho minhas opções de garantia estendida '#{row[:garantiaEstendida]}' e seguro '#{row[:seguroRoubo]}' --ExtendedWarrantyPage"
    step "movo o produto para o carrinho --ExtendedWarrantyPage"
    step "aumento a quantidade do produto '#{row[:sku2]}' para '#{row[:quantidade2]}' --CartPage"
    step 'clico em comprar --CartPage'
    step "seleciono o endereço '#{row[:endereço]}' --AddressPage"
    step "seleciono o tipo de entrega '#{'random'}' --AddressPage"
    step "seleciono o tipo de entrega '#{row[:opção_de_entrega]}' --AddressPage"
    step 'movo o produto para a página de pagamento --AddressPage'
  end
end

Quando("finalizo a compra --PaymentPage") do |table|
  table.hashes.each do |row|
    case row[:forma_de_pagamento].downcase
    when 'cartão de crédito'
      step "finalizo a compra com a opção de cartão de crédito para a bandeira '#{row[:dados_pagamento]}' e 'random' parcelas --PaymentPage"
    when 'boleto'
      step "finalizo a compra com a opção de boleto --PaymentPage"
    when 'débito online'
      step "finalizo a compra com a opção de débito online para '#{row[:dados_pagamento]}' --PaymentPage"
    when 'paypal'
      raise 'Implementar step para pagamento com paypal'
    when 'multicheque'
      step "finalizo a compra com a opção de multicheque para a bandeira '#{row[:dados_pagamento]} --PaymentPage'"
    when 'cartão presente'
      raise 'Implementar step para pagamento com cartao presente'
    when 'visa checkout'
      raise 'Implementar step para pagamento com visa checkout'
    when 'masterpass'
      raise 'Implementar step para pagamento com masterpass'
    else
      tracing_error "Erro! Forma de pagamento #{row[:forma_de_pagamento]} inválida"
    end
  end
end

