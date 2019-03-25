#language: pt
#encoding: utf-8

@FullStore
@FullSmoke
@UserData

Funcionalidade: Alterar dados

  - Narrativa:
  Alterar dados do usuário


  Contexto: Acessar página home do site da bandeira
    Dado que estou na tela inicial do site da bandeira --HomePage
    E estou logado com um novo usuário criado via API --LoginPage
    E acesso meus dados cadastrais --AccountPage

  Esquema do Cenario: Validar alteração de email
    Entao eu altero meu email com sucesso para "<novo_email>" --AccountPage

    Exemplos:
      | novo_email |
      | random    |

  Esquema do Cenario: Validar alteração de senha
    Entao eu altero minha senha com sucesso para "<nova_senha>" --AccountPage

    Exemplos:
      | nova_senha |
      | default    |

