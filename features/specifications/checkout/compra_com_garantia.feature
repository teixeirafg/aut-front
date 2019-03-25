#language: pt
#encoding: utf-8

@FullEnv
@FullStore
@FullSmoke
@Checkout
@Compra_garantia
@Multicanal
@ignoreMobile

Funcionalidade: Finalizar compras com garantia estendida

  - Narrativa:
  Finalizar compras com garantia estendida e as posibilidades de:
  cartao de credito, boleto bancario, visa checkout, paypal e rede pay.
  utilizando usuarios cadastrados, com e sem garantia

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage


  @ignoreCasasBahia
  @ignorePontoFrio
  Esquema do Cenario: Validar adicao de garantia estendida em compra normal com cartão de crédito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto selecionando apenas garantia até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | endereço   |
      | <sku> | <garantiaEstendida> | <endereço> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira_cartão>" e "<qty_parcelas>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | sku          | garantiaEstendida | usuario | endereço | bandeira_cartão | qty_parcelas |
      | sku_garantia | random            | qa_2    | random   | random          | random       |
      | sku_garantia | 12                | qa_2    | random   | random          | random       |
      | sku_garantia | 24                | qa_2    | random   | random          | random       |
      | sku_garantia | 36                | qa_2    | random   | random          | random       |


  @ignoreExtra
  @ignoreBarateiro
  Esquema do Cenario: Validar adicao de garantia estendida em compra normal com cartão de crédito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto selecionando garantia e seguro até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | endereço   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <endereço> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira_cartão>" e "<qty_parcelas>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | sku          | garantiaEstendida | seguroRoubo    | usuario | endereço | bandeira_cartão | qty_parcelas |
      | sku_garantia | random            | random         | qa_2    | random   | random          | random       |
      | sku_garantia | 12                | roubo          | qa_2    | random   | random          | random       |
      | sku_garantia | 24                | quebra         | qa_2    | random   | random          | random       |
      | sku_garantia | 36                | roubo_e_quebra | qa_2    | random   | random          | random       |


