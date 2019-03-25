#encoding: utf-8
Quando('confirmo que o número do pedido foi apresentado --FinishedPayment') do
  WaitPage.new
  $numero_pedido = finished_payment.get_numero_pedido
  expecting !$numero_pedido.empty?, true, "Pedido realizado com sucesso. Número do pedido: #{$numero_pedido}"
end

Entao('valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment') do
  finished_payment.go_to_order_detail
  if MOBILE
    step 'verifico que meu pedido é apresentado com sucesso na tela de detalhes --MyOrdersPage'
  else
    step 'verifico que meu pedido foi encontrado com sucesso no campo de pesquisa --MyOrdersPage'
  end
end