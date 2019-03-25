#encoding: utf-8
E('clico em comprar --CartPage') do
  cart.is_cart_page
  cart.click_concluir_compra
  tracing 'Move o produto do carrinho para a página seguinte'
end

E('verifico se a garantia escolhida anteriormente confere com a apresentada no carrinho --CartPage') do
  expecting(cart.check_right_warranty, true, 'Verifica se a garantia foi apresentada corretamente no carrinho')

end

E('verifico que o carrinho está vazio --CartPage') do
  expecting(cart.check_empty_cart, true, 'Checa se o carrinho está vazio')
end

E('verifico que o carrinho não está vazio --CartPage') do
  expecting(cart.check_empty_cart, false, 'Checa se o carrinho está vazio')
end

E('verifico se há produtos no carrinho --CartPage') do
  #Se caso houver produtos no carrinho, os mesmos serão removidos
  cart.acess_cart_page
  cart.remove_products
end

E('verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage') do |table|
  step 'realizo login com usuário parametrizado  --LoginPage', table
  cart.acess_cart_page
  cart.remove_products
end

E('sou redirecionado para o carrinho vazio --CartPage') do
  expecting(cart.check_empty_cart, true, 'Checa que o carrinho está vazio')
end
E('aumento a quantidade do produto {string} para {string} --CartPage') do |sku, qtd|
  cart.raise_product_quantity sku, qtd
  tracing 'Alterada quantidade do produto'
end
