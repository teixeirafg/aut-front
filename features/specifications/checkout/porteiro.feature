#language: pt
#encoding: utf-8


@porteiro

@toDo
@ignoreMobile
@ignoreDesktop
Funcionalidade: Validar Porteiro

  - Narrativa:
  Validar se porteiro esta sendo chamado ao trocar de produtos, e formas de entrega,
  utilizando serviços.

  @frtmc1654 @frtmc1655 @frtmc1671
  Esquema do Cenario: Realizar a validacao do Porteiro  trocando de produto normal para Retira
    E verifico se há produtos no carrinho logando com um usuário parametrizado --CartPage
      | usuario   |
      | <usuario> |
    Quando levo dois produtos até o porteiro --PorterPage
      | sku   | sku2   | garantiaEstendida   | seguroRoubo   | endereço   | cep   | ponto_retirada  |
      | <sku> | <sku2> | <garantiaEstendida> | <seguroRoubo> | <endereço> | <cep> | <pontoRetirada> |
    E seleciono a opção concluir apenas a compra do ultimo produto selecionado --PorterPage
    E escolho minhas opções de garantia estendida "<garantiaEstendida>" e seguro "<seguroRoubo>" --ExtendedWarrantyPage"
    Então confirmo que o produto selecionado "<sku2>" é apresentado no carrinho --CartPayment

    Exemplos:
      | usuario           | sku                   | sku2 | garantiaEstendida | seguroRoubo | cep       | pontoRetirada |
      | usuarioBlackList2 | sku_retira_lockers_sp |      |                   |             | Locker_SP | lockers       |
      | usuarioBlackList2 | sku_retira_lockers_sp |      |                   |             | Locker_SP | lockers       |
      | usuarioBlackList3 | sku_retira_lockers_sp |      |                   |             | Locker_SP | lockers       |




