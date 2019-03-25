#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@Registration
@Multicanal
@BugCaptcha
Funcionalidade: Cadastro

  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage

  @ShortSmoke
  Esquema do Cenario: Validar cadastro de Pessoa Fisica
    E vou até a página de cadastro --RegisterPage
    Quando me registro com usuário Pessoa Física com email "<email>", senha "<senha>" e demais dados aleatórios --RegisterPage
    Então sou cadastrado com sucesso - RegisterPage

    Exemplos:
      | email     | senha     |
      | random    | Varejo123 |


  Esquema do Cenario: Validar cadastro de Pessoa Jurídica
    E vou até a página de cadastro --RegisterPage
    Quando me registro com usuário Pessoa Jurídica com email "<email>", senha "<senha>" e demais dados aleatórios --RegisterPage
    Então sou cadastrado com sucesso - RegisterPage

    Exemplos:
      | email   | senha    |
      | random  | Varejo123|





