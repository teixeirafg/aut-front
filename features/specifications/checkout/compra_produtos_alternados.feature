#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@Checkout
@Multicanal

Funcionalidade: Finalizar compras - Produtos alternados

  - Narrativa:
  Finalizar compras com as posibilidades de:
  cartao de credito, boleto bancario, visa checkout, paypal e rede pay.
  utilizando usuarios cadastrados, com e sem garantia

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @Produto @frtmc1504
  Esquema do Cenario: Realizar compra Normal com produto Marketplace
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo um produto normal até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | quantidade   | endereço   | opção_de_entrega   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario | sku     | garantiaEstendida | seguroRoubo | quantidade | endereço | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | qa_1    | sku_mkt |                   |             |            | random   | random           | cartão de crédito  | visa            |


  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @compra @frtmc1611 @ftrmc1612 @done
  Esquema do Cenario: Realizar compra MESMO DIA com 1 sku, qtde = 1 , com cartão de crédito
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo um produto normal até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | quantidade   | endereço   | opção_de_entrega   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku            | garantiaEstendida | seguroRoubo | quantidade | endereço           | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList4 | sku_mesmo_dia  |                   |             | 1          | Outro SP Mesmo Dia | mesmo_dia        | cartão de crédito  | visa            |
      | usuarioBlackList4 | sku_mesmo_dia2 |                   |             | 3          | Outro SP Mesmo Dia | mesmo_dia        | cartão de crédito  | visa            |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @ignoreCasasBahia
  @compra @frtmc1624 @frtmc1625 @toDo
  Esquema do Cenario: Realizar compra MESMO DIA com 2 skus diferente , com cartão de crédito
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo dois produtos normais até a página de pagamento já logado --PaymentPage
      | sku   | sku2   | garantiaEstendida   | seguroRoubo   | quantidade   | quantidade2   | endereço   | opção_de_entrega   |
      | <sku> | <sku2> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <quantidade2> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido para os 2 produtos com a quantidade informada --MyOrdersPage
      | sku1    | sku2     | quantidade1 | quantidade2 |
      | sku_kit | sku_kit2 | 1           | 1           |

    Exemplos:
      | usuario           | sku            | sku2           | garantiaEstendida | seguroRoubo | quantidade | quantidade2 | endereço           | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList5 | sku_mesmo_dia  | sku_mesmo_dia3 |                   |             | 1          | 1           | Outro SP_Mesmo Dia | mesmo_dia        | cartão de crédito  | visa            |
      | usuarioBlackList5 | sku_mesmo_dia2 | sku_mesmo_dia4 | 12                |             | 1          | 1           | Outro SP_Mesmo Dia | mesmo_dia        | cartão de crédito  | visa            |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @ignoreCasasBahia
  @compra @frtmc1627 @toDo
  Esquema do Cenario: Realizar compra MESMO DIA com 1 sku , com GES, com 2 cartões de crédito
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo um produto normal até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | quantidade   | endereço   | opção_de_entrega   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <endereço> | <opção_de_entrega> |
    E finalizo a compra com dois cartões de crédito para a bandeira "<bandeira_cartão>" e "<parcelas>" parcelas e para a bandeira "<bandeira_cartão2>" e "<parcelas2>" parcelas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku            | garantiaEstendida | seguroRoubo | quantidade | endereço           | opção_de_entrega | bandeira_cartão | parcelas | bandeira_cartão2 | parcelas2 |
      | usuarioBlackList5 | sku_mesmo_dia2 | 12                |             | 1          | Outro SP_Mesmo Dia | mesmo_dia        | visa            | 2        | master1          | 2         |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @ignoreCasasBahia
  @compra @frtmc1559 @frtmc1502 @toDo
  Esquema do Cenario: Realizar compra NORMAL com produto KIT e item avulso qtde > 1
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo dois produtos normais até a página de pagamento já logado --PaymentPage
      | sku   | sku2   | garantiaEstendida   | seguroRoubo   | quantidade   | quantidade2   | endereço   | opção_de_entrega   |
      | <sku> | <sku2> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <quantidade2> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido com a quantidade informada "<quantidade>" na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku      | sku2            | garantiaEstendida | seguroRoubo | quantidade | quantidade2 | endereço | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList2 | sku_kit  | sku_kit_avulso  |                   |             | 2          | 2           | random   | Normal           | cartão de crédito  | visa            |
      | usuarioBlackList2 | sku_kit2 | sku_kit2_avulso |                   |             | 1          | 1           | random   | Normal           | cartão de crédito  | visa            |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @ignoreCasasBahia
  @compra @frtmc1757 @toDo

  Cenario: Realizar compra NORMAL com 2 produtos KIT com qtde igual a 1
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario           |
      | usuarioBlackList3 |
    Quando levo dois produtos normais até a página de pagamento já logado --PaymentPage
      | sku     | sku2     | garantiaEstendida | seguroRoubo | quantidade | quantidade2 | endereço | opção_de_entrega |
      | sku_kit | sku_kit2 |                   |             | 1          |             | random   | Normal           |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento | dados_pagamento |
      | cartão de crédito  | visa            |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido para os 2 produtos com a quantidade informada --MyOrdersPage
      | sku1    | sku2     | quantidade1 | quantidade2 |
      | sku_kit | sku_kit2 | 1           | 1           |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @ignoreCasasBahia
  @compra @frtmc1579 @toDO
  Esquema do Cenario: Realizar compra NORMAL com produto KIT e item avulso qtde > 1
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo dois produtos normais até a página de pagamento já logado --PaymentPage
      | sku   | sku2   | garantiaEstendida   | seguroRoubo   | quantidade   | quantidade2   | endereço   | opção_de_entrega   |
      | <sku> | <sku2> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <quantidade2> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido com a quantidade informada "<quantidade>" na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku      | sku2            | garantiaEstendida | seguroRoubo | quantidade | quantidade2 | endereço | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList2 | sku_kit  | sku_kit_avulso  |                   |             | 2          | 2           | random   | Normal           | visa               | visa            |
      | usuarioBlackList2 | sku_kit2 | sku_kit2_avulso |                   |             | 1          | 1           |          |                  |                    |                 |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @compra @frtmc1499 @done
  Esquema do Cenario: Realizar a compra de 1 produto Normal, com cartao de credito - Download - RETIRA
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto normal até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | quantidade   | endereço   | opção_de_entrega   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido com a quantidade informada "<quantidade>" na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku          | garantiaEstendida | seguroRoubo | quantidade | endereço     | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList2 | sku_download |                   |             | 1          | Comercial SP | Normal           | cartão de crédito  | master1         |

  @ignoreBarateiro
  @ignoreExtra
  @ignorePontoFrio
  @compra @frtmc1498 @done
  Esquema do Cenario: Realizar a compra de 1 produto Normal, com cartao de credito - Tecnoponto ( instalação TV )
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto normal até a página de pagamento já logado --PaymentPage
      | sku   | garantiaEstendida   | seguroRoubo   | quantidade   | endereço   | opção_de_entrega   |
      | <sku> | <garantiaEstendida> | <seguroRoubo> | <quantidade> | <endereço> | <opção_de_entrega> |
    E finalizo a compra --PaymentPage
      | forma_de_pagamento   | dados_pagamento   |
      | <forma_de_pagamento> | <dados_pagamento> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido com a quantidade informada "<quantidade>" na tela Meus Pedidos --MyOrdersPage

    Exemplos:
      | usuario           | sku            | garantiaEstendida | seguroRoubo | quantidade | endereço     | opção_de_entrega | forma_de_pagamento | dados_pagamento |
      | usuarioBlackList3 | sku_tecnoponto |                   |             | 1          | Comercial SP | Normal           | cartão de crédito  | master1         |

  @ignoreDesktop
  @ignoreMobile
  Esquema do Cenario: Validar compra normal com débito
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando levo um produto até a página de pagamento já logado --PaymentPage
      | sku   | endereço   |
      | <sku> | <endereço> |
    E finalizo a compra com a opção de débito online para "<forma_debito_pagamento>" --PaymentPage
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --FinishedPayment

    Exemplos:
      | sku       | usuario | endereço | forma_debito_pagamento |
      | sku_comum | qa_1    | default  | random                 |
