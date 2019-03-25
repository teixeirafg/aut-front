  #language: pt
  #encoding: utf-8



  @ignoreExtra
  @ignorePontoFrio
  @ignoreBarateiro
  Funcionalidade: Finalizar compras Retira

    - Narrativa:
    Finalizar compras Retira

    Contexto: Acessar página home do site da bandeira
      Dado que estou na tela inicial do site da bandeira --HomePage

    @retira @frtmc1761 @frtmc1762 @done
    Esquema do Cenario: Realizar Compra Retira com aumento de quantidade no carrinho
      E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
        | usuario   |
        | <usuario> |
      Quando levo um produto retira até a página de pagamento já logado --PaymentPage
        | sku   | garantiaEstendida   | seguroRoubo   | endereço   | cep   | ponto_retirada  | quantidade   |
        | <sku> | <garantiaEstendida> | <seguroRoubo> | <endereço> | <cep> | <pontoRetirada> | <quantidade> |
      E finalizo a compra --PaymentPage
        | forma_de_pagamento   | dados_pagamento   |
        | <forma_de_pagamento> | <dados_pagamento> |
      Então confirmo que o número do pedido foi apresentado --FinishedPayment
      E valido a inclusao do pedido com a quantidade informada "<quantidade>" na tela Meus Pedidos --MyOrdersPage

      Exemplos:
        | usuario           | sku                     | garantiaEstendida | seguroRoubo | endereço     | cep       | pontoRetirada | quantidade | forma_de_pagamento | dados_pagamento   |
        | usuarioBlackList2 | sku_comum               | 12                | roubo       | Comercial SP | Retira_SP | retira        | 2          | Débito Online      | Débito Banco Itaú |
        | usuarioBlackList3 | sku_retira_loja_leve_sp |                   |             | Comercial SP | Retira_SP | retira        | 2          | cartão de crédito  | visa              |


    @retira @frtmc1555 @frtmc1556 @frtmc1551 @frtmc1557 @frtmc1552 @frtmc1553 @done
    Esquema do Cenario: Realizar Compra Retira página do logista
      E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
        | usuario   |
        | <usuario> |
      Quando levo um produto retira logista até a página de pagamento já logado --PaymentPage
        | sku   | garantiaEstendida   | seguroRoubo   | endereço   | cep   | ponto_retirada  |
        | <sku> | <garantiaEstendida> | <seguroRoubo> | <endereço> | <cep> | <pontoRetirada> |
      E finalizo a compra --PaymentPage
        | forma_de_pagamento   | dados_pagamento   |
        | <forma_de_pagamento> | <dados_pagamento> |
      Então confirmo que o número do pedido foi apresentado --FinishedPayment
      E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

      Exemplos:
        | usuario           | sku                      | garantiaEstendida | seguroRoubo | endereço         | cep        | pontoRetirada       | forma_de_pagamento | dados_pagamento |
        | usuarioBlackList2 | sku_retira_loja_leve_sp  |                   |             | Comercial SP     | Retira_SP  | retira estoque loja | cartão de crédito  | visa            |
        | usuarioBlackList2 | sku_retira_loja1_leve_sp | 12                | roubo       | Comercial SP     | Retira_SP  | retira estoque loja | cartão de crédito  | visa            |
        | usuarioBlackList3 | sku_retira_loja1_leve_sp |                   |             | Comercial SP     | Retira_SP  | retira estoque site | cartão de crédito  | visa            |
        | usuarioBlackList3 | sku_retira_loja1_leve_sp | 12                | roubo       | Comercial SP     | Retira_SP  | retira estoque site | cartão de crédito  | visa            |
        | usuarioBlackList2 | sku_comum                |                   |             | Outro SP_Locker  | Locker_SP  | lockers             | cartão de crédito  | visa            |
        | usuarioBlackList2 | sku_comum                |                   |             | Outro SP_Correio | Correio_SP | correios            | cartão de crédito  | visa            |


    @retira @frtmc1797 @frtmc1798 @frtmc1799 @frtmc1801 @frtmc1803 @done
    Esquema do Cenario: Realizar a compra de 1 produto retira
      E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
        | usuario   |
        | <usuario> |
      Quando levo um produto retira até a página de pagamento já logado --PaymentPage
        | sku   | garantiaEstendida   | seguroRoubo   | endereço   | cep   | ponto_retirada  | quantidade   |
        | <sku> | <garantiaEstendida> | <seguroRoubo> | <endereço> | <cep> | <pontoRetirada> | <quantidade> |
      E finalizo a compra --PaymentPage
        | forma_de_pagamento   | dados_pagamento   |
        | <forma_de_pagamento> | <dados_pagamento> |
      Então confirmo que o número do pedido foi apresentado --FinishedPayment
      E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage

      Exemplos:
        | usuario           | sku                    | garantiaEstendida | seguroRoubo | endereço         | cep        | pontoRetirada | quantidade | forma_de_pagamento | dados_pagamento   |
        | usuarioBlackList2 | sku_retira_lockers_sp  |                   |             | Outro SP_Locker  | Locker_SP  | lockers       | 1          | cartão de crédito  | visa              |
        | usuarioBlackList2 | sku_retira_lockers_sp  |                   |             | Outro SP_Locker  | Locker_SP  | lockers       | 1          | débito online      | Débito Banco Itaú |
        | usuarioBlackList3 | sku_retira_lockers_sp  |                   |             | Outro SP_Locker  | Locker_SP  | lockers       | 1          | boleto             |                   |
        | usuarioBlackList2 | sku_retira_correios_sp |                   |             | Outro SP_Correio | Correio_SP | correios      | 1          | cartão de crédito  | visa              |
        | usuarioBlackList2 | sku_retira_correios_sp |                   |             | Outro SP_Correio | Correio_SP | correios      | 1          | débito online      | Débito Banco Itaú |
        | usuarioBlackList2 | sku_retira_correios_sp |                   |             | Outro SP_Correio | Correio_SP | correios      | 1          | boleto             |                   |


