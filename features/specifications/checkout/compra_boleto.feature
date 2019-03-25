#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@Checkout
@Multicanal

Funcionalidade: Finalizar compras - Boleto com novo cadastro

  - Narrativa:
  Finalizar compras com as posibilidades de:
  boleto bancario

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage

  Esquema do Cenario: Validar compra normal com boleto
    Quando levo um produto até a página de pagamento com um novo usuário via api --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com a opção de boleto --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku                   |  endereço | tipo_entrega  |
      | sku_comum             | default  | random        |
      | sku_comum             | default  | normal        |
      | sku_agendada          | default  | agendada      |
      | sku_retira_lockers_sp | default  | retira_rapido |

  @ignoreFullSmoke
  @ShortSmoke
  Esquema do Cenario: Validar compra normal com boleto
    Quando levo um produto até a página de pagamento com um novo usuário via api --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com a opção de boleto --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku                   |  endereço | tipo_entrega  |
      | sku_comum             | default  | random        |


  @ignoreBarateiro
  @ignoreMobile
  @ignoreDesktop
  @ignoreMobile
  Esquema do Cenario: Validar compra normal com um cartão e boleto
    Quando levo um produto até a página de pagamento com um novo usuário via api --PaymentPage
      | sku   | endereço   | tipo_entrega   |
      | <sku> | <endereço> | <tipo_entrega> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira_cartão>" e "<parcelas>" parcelas e boleto --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku          | endereço | tipo_entrega | bandeira_cartão | parcelas |
      | sku_comum    | default  | random       | random          | random   |
      | sku_agendada | default  | agendada     | visa            | 2        |

