#encoding: utf-8

E('vou para a página de login --HomePage') do
  @home.login_access
  expecting login.is_login_page, true, 'Verifica que está na página de login'
end

E('vou para a página de login navegando pela url --HomePage') do
  @home.login_access_url
  expecting login.is_login_page, true, 'Verifica que está na página de login'
end

Dado('que estou na tela inicial do site da bandeira --HomePage') do
  @home = home
  @home.load
  @home.loaded?
  home.access_validation
  tracing 'Acessando a homepage', true
  #expecting home.is_home_page, true, 'Acessando a homepage'
end

Dado('vou para a página inicial --HomePage') do
  @home = home
  @home.load
end


Dado('acesso a minha conta --HomePage') do
  home.my_account_access
end

Dado('acesso a tela de pedidos --HomePage') do
  home.my_orders_access
end