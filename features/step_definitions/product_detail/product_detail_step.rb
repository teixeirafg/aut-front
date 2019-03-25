require 'pry'

E('adiciono o produto ao meu carrinho --ProductDetailPage') do
  product_detail.click_buy
end

E('que procuro via url um produto com sku {string} --ProductDetailPage') do |string|
  product_detail.search_sku string, false
  tracing "Acessando o produto com sku do tipo: #{string}. SKU: #{$sku}"
  #expecting product_detail.is_product_page, true, 'Verifica o acesso a página de detalhes do produto'
end

E ('sou redirecionado para a página do logista') do
  product_detail.click_more_options
end

E ('Clico em retira rápido --ProductDetailPage') do
  product_detail.click_withdraw_fast
end

E ('Informo o Cep {string} no modal retira rápido --ProductDetailPage') do |string|
  modal_withdraw_fast.search_cep string
end

E ('Seleciono o local de retirada {string} no modal retira rapido --ProductDetailPage') do |ponto_retirada|
  modal_withdraw_fast.select_withdraw_point ponto_retirada
end

E ('Seleciono uma loja para retirada com o cep {string} e local de retirada {string} --ProductDetailPage') do |cep, ponto_retirada|
  modal_withdraw_fast.select_store_withdraw cep, ponto_retirada
end


E('seleciono uma loja para retira rápido --ProductDetailPage') do |table|
  table.hashes.each do |row|
    product_detail.click_withdraw_fast
    modal_withdraw_fast.search_cep row[:cep]
    modal_withdraw_fast.select_withdraw_point row[:ponto_retirada]
  end

end



