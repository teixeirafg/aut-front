#language: pt
#encoding: utf-8

@FullSmoke
@ListaCasamento
@ignorePontoFrio @ignoreExtra @ignoreBarateiro
@ignoreStg @ignoreHlg @ignoreDev
@ignoreMobile
Funcionalidade: Lista de casamento
  Como usuário do sistema, quero poder cadastrar lista de casamento, inserir itens na lista de presentes e
  comprar presentes como convidado

  Contexto: Acessar página inicial da lista de casamento
    Dado que estou na tela inicial do site da bandeira --HomePage
    E estou logado com um usuário parametrizado --LoginPage
      | usuario |
      | qa_1    |
    E que estou na tela de lista de casamento como convidado do site da bandeira --WeddingListPage

  @fechar_pedido_para_lista_casamento
  Cenario: Fechar pedido para uma lista de casamento
    Dado que realizo busca por nome dos noivos "teste" --WeddingListPage
    E seleciono produto na lista de desejos --WeddingListPage
    Quando movo produto para o carrinho enviando mensagem aos noivos --WeddingListPage
    Então finalizo a compra pelo fluxo de lista de casamentos -WeddingListPage
      | bandeira_cartao | qty_parcelas |
      | random          | random       |
