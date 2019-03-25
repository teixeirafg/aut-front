#language: pt
#encoding: utf-8

@ignoreMobile
@ignoreDesktop
@onlyForDev


Funcionalidade: Cadastro endereço

  Esquema do Cenario: Criar endereço
    Então crio um endereço novo para o email "<email>" e senha "<senha>" para o cep "<cep>" --RegisterPage

    Exemplos:
      | email                                      | senha  | cep |
      | user_automacao03112014_090638117@cnova.com | 123456 | rj  |



