#encoding: utf-8

Dado('faço o login com {string} e {string} --LoginPage') do |usuario, senha|
  login.do_login(usuario, senha)
  tracing "Efetuando login com usuário: #{usuario} e senha: #{senha}"
end

Dado('faço o login com meu usuário parametrizado {string} --LoginPage') do |usuario|
  login.do_login_from_properties usuario, false
  tracing "Efetua login com base nos dados do usuário #{usuario} do arquivo properties. Email: #{$usuario_email}"
end

Dado('escolho me cadastrar com um novo usuário --LoginPage') do
  login.choose_new_user
  tracing "Seleciona a opção de cadastro com novo usuário"
end

E('estou logado com sucesso --LoginPage') do
  if MOBILE
    expecting(account.is_account_page, true, 'Checa se foi direcionado para a página de conta do usuário após cadastro')
  end
  delete_sku_cart_api $usuario_email, $usuario_senha

end

E('estou logado com um usuário parametrizado --LoginPage') do |table|
  table.hashes.each do |row|
    step 'vou para a página de login --HomePage'
    step "faço o login com meu usuário parametrizado '#{row[:usuario]}' --LoginPage"
    step 'estou logado com sucesso --LoginPage'
  end

end


E('estou logado com um novo usuário criado via API --LoginPage') do
    step 'vou para a página de login --HomePage'
    step 'crio um usuário via API - RegisterPage'
    step "faço o login com '#{$usuario_email}' e '#{$usuario_senha}' --LoginPage"
    step 'estou logado com sucesso --LoginPage'
end

E ('realizo login com usuário parametrizado  --LoginPage') do |table|
  table.hashes.each do |row|
    step 'vou para a página de login navegando pela url --HomePage'
    step "faço o login com meu usuário parametrizado '#{row[:usuario]}' --LoginPage"
  end
end