#language: pt
#encoding: utf-8

@toDo
@ignoreMobile
@ignoreDesktop
Funcionalidade: Finalizar compras Reserva Site

  - Narrativa:
  Finalizar compras Reserva Site

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage

  @Produto_Modal_Retira_Rapido @FRTMC_1806 @toDo
  Esquema do Cenario: Realizar compra de 1 produto RESERVA SITE - usuario logado
    E estou logado com um usuário parametrizado --LoginPage
      | usuario   |
      | <usuario> |
    Quando solicito uma reserva de um produto no site
      | sku   | endereço   | cep   | ponto_retirada   | quantidade   |
      | <sku> | <endereço> | <cep> | <ponto_retirada> | <quantidade> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage
    Exemplos:
      | usuario           | sku                     | endereço     | ponto_retirada | quantidade |
      | usuarioBlackList2 | sku_retira_loja_leve_sp | Comercial SP | retira         | 1          |
      | usuarioBlackList3 | sku_retira_loja_leve_sp | Comercial SP | retira         | 1          |

  @Produto_Modal_Retira_Rapido @FRTMC_1807 @toDo
  Esquema do Cenario: Realizar compra de 1 produto RESERVA SITE - usuario novo
    E vou até a página de cadastro --RegisterPage
    Quando me registro com usuário Pessoa Física com email "<email>", senha "<senha>" e demais dados aleatórios --RegisterPage
    E solicito uma reserva de um produto no site logando com usuário parametrizado
      | sku   | endereço   | email   | senha   | ponto_retirada   | quantidade   |
      | <sku> | <endereço> | <email> | <senha> | <ponto_retirada> | <quantidade> |
    Então confirmo que o número do pedido foi apresentado --FinishedPayment
    E valido a inclusao do pedido na tela Meus Pedidos --MyOrdersPage
    Exemplos:
      | email  | senha  | sku                     | endereço     | ponto_retirada | quantidade |
      | random | random | sku_retira_loja_leve_sp | Comercial SP | retira         | 1          |
      | random | random | sku_retira_loja_leve_sp | Comercial SP | retira         | 1          |
