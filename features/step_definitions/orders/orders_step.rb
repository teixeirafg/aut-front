#encoding: utf-8
Entao('valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage') do
  expecting orders.acess_page_orders, true, 'accessa a tela de Meus pedidos'
  order = orders.search_order $numero_pedido
  expecting order, true, "Encontra o pedido número #{$numero_pedido}"
end

Entao('verifico que meu pedido é apresentado com sucesso na tela de detalhes --MyOrdersPage') do
  expecting(orders.check_order($numero_pedido), true, "Encontra o pedido número #{$numero_pedido}")
end

Entao('valido a inclusao do pedido com a quantidade informada {string} na tela Meus Pedidos --MyOrdersPage') do |qtd|

  expecting orders.acess_page_orders, true, 'accessa a tela de Meus pedidos'
  order = orders.search_order ($numero_pedido)
  expecting order, true, "Encontra o pedido número #{$numero_pedido}"
  rise_quantity = orders.check_quantity_product qtd
  expecting rise_quantity, true, 'Verifica a qtd de itens do produto no carrinho'

end

Entao('verifico que meu pedido foi encontrado com sucesso no campo de pesquisa --MyOrdersPage') do
  expecting(orders.search_order($numero_pedido), true, "Encontra o pedido número #{$numero_pedido}")
end


Entao('acesso a aba relativa aos meus dados pessoais --MyOrdersPage') do
  orders.access_my_profile_tab
end







