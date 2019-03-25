#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@Checkout
@Multicanal

Funcionalidade: Finalizar compras - Um Cartão

  - Narrativa:
  Finalizar compras com as posibilidades de:
  cartao de credito, boleto bancario, visa checkout, paypal e rede pay.
  utilizando usuarios cadastrados, com e sem garantia

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage


  Esquema do Cenario: Validar compra normal com cartão de crédito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto até a página de pagamento já logado --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira_cartão>" e "<qty_parcelas>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku           | usuario            | endereço | tipo_entrega | bandeira_cartão | qty_parcelas |
      | sku_comum     | usuarioBlackListPJ | default  | random       | random          | random       |
      | sku_comum     | qa_1               | default  | random       | random          | random       |
      | sku_comum     | qa_1               | default  | normal       | visa            | 3            |
      | sku_agendada  | qa_1               | default  | agendada     | master          | 1            |
      | sku_mesmo_dia | usuarioBlackList4  | default  | mesmo_dia    | master          | 2            |


  @ignoreFullSmoke
  @ShortSmoke
  Esquema do Cenario: Validar compra normal com cartão de crédito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto até a página de pagamento já logado --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira_cartão>" e "<qty_parcelas>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku       | usuario | endereço | tipo_entrega | bandeira_cartão | qty_parcelas |
      | sku_comum | qa_1    | default  | random       | random          | random       |
