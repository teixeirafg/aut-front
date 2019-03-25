#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@Checkout
@Multicanal

Funcionalidade: Finalizar compras - Dois cartões

  - Narrativa:
  Finalizar compras com as posibilidades de:
  cartao de credito, boleto bancario, visa checkout, paypal e rede pay.
  utilizando usuarios cadastrados, com e sem garantia

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage

  Esquema do Cenario: Validar compra normal com dois cartões de crédito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto até a página de pagamento já logado --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com dois cartões de crédito para a bandeira "<bandeira_cartão>" e "<parcelas>" parcelas e para a bandeira "<bandeira_cartão2>" e "<parcelas2>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku                   | usuario | endereço | tipo_entrega  | bandeira_cartão  | parcelas | bandeira_cartão2 | parcelas2 |
      | sku_comum             | qa_1    | default  | random        | random           | random   | random           | random    |
      | sku_comum             | qa_1    | default  | random        | master           | random   | master           | random    |
      | sku_comum             | qa_1    | default  | normal        | visa             | random   | master           | random    |
      | sku_agendada          | qa_1    | default  | agendada      | elo              | random   | hipercard        | random    |
      | sku_retira_lockers_sp | qa_1    | default  | retira_rapido | american_express | random   | diners           | random    |
