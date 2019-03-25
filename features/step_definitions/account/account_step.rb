#encoding: utf-8
Dado('acesso meus dados cadastrais --AccountPage') do
  #step 'vou para a página inicial --HomePage'
  if MOBILE
    #step 'acesso a minha conta --HomePage'
    account.access_user_data_mobile

  else
    #step 'acesso a tela de pedidos --HomePage'
    step 'acesso a aba relativa aos meus dados pessoais --MyOrdersPage'
  end

end


E('eu altero minha senha com sucesso para {string} --AccountPage') do |nova_senha|
  if nova_senha.casecmp 'default'
    msg = '123456A'
  else
    msg = nova_senha
  end
  expecting(account.change_password(nova_senha), true, "Altera a senha para #{msg}")
end

E('eu altero meu email com sucesso para {string} --AccountPage') do |novo_email|
  expecting(account.change_email(novo_email), true, "Altero meu email")
end




