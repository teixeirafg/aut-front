#encoding: utf-8


Dado('me registro com usuário Pessoa Física com email {string}, senha {string} e demais dados aleatórios --RegisterPage') do |email, password|
  if MOBILE
    register.fill_pf_data_mobile 'random', 'random', 'random', 'random'
    register.fill_phone_mobile 'random'
  else
    register.fill_pf_data 'random', 'random', 'random', 'random', 'random', 'random'
    register.fill_pf_phones 'random', 'random', 'random', 'random'
  end

  register.fill_log_in_info email, password
  register.finish_registration
end


Dado('me registro com usuário Pessoa Jurídica com email {string}, senha {string} e demais dados aleatórios --RegisterPage') do |email, password|
  register.choose_pj
  register.fill_pj_data 'random', 'random', 'random', 'random', 'random', 'random', 'random'
  if MOBILE
    register.fill_phone_mobile 'random'
  else
    register.fill_pj_phones 'random', 'random', 'random', 'random'
  end
  register.fill_log_in_info email, password
  register.finish_registration
end

Quando('vou até a página de cadastro --RegisterPage') do
  step 'vou para a página de login --HomePage'
  step 'escolho me cadastrar com um novo usuário --LoginPage'
end

E('sou cadastrado com sucesso - RegisterPage') do
  if MOBILE
    expecting(account.is_account_page, true, 'Checa se foi direcionado para a página de conta do usuário após cadastro')
  else
    expecting(cart.check_empty_cart, true, 'Checa que foi direcionado para o carrinho após o cadastro')
  end
end

Quando('levo um produto até a página de cadastro --RegisterPage') do |table|
  table.hashes.each do |row|
    step "que procuro via url um produto com sku '#{row[:sku]}' --ProductDetailPage"
    step 'adiciono o produto ao meu carrinho --ProductDetailPage'
    step 'movo o produto para o carrinho --ExtendedWarrantyPage'
    step 'clico em comprar --CartPage'
    step 'escolho me cadastrar com um novo usuário --LoginPage'
  end
end

Dado('crio um endereço novo para o email {string} e senha {string} para o cep {string} --RegisterPage') do |email, password, cep|
  users = 'user_automacao03112014_090638117@cnova.com,user_automacao03112014_090638288@cnova.com,user_automacao03112014_090638475@cnova.com,user_automacao03112014_090638741@cnova.com,user_automacao03112014_090638912@cnova.com,user_automacao03112014_090639037@cnova.com,user_automacao03112014_090639209@cnova.com,user_automacao03112014_090639349@cnova.com,user_automacao03112014_090639474@cnova.com,user_automacao03112014_090639677@cnova.com,user_automacao03112014_090640425@cnova.com,user_automacao03112014_090647679@cnova.com,user_automacao03112014_090647804@cnova.com,user_automacao03112014_090647991@cnova.com,user_automacao03112014_090648163@cnova.com,user_automacao03112014_090648413@cnova.com,user_automacao03112014_090639848@cnova.com,user_automacao03112014_090640020@cnova.com,user_automacao03112014_090640223@cnova.com,user_automacao03112014_090640597@cnova.com,user_automacao03112014_090640878@cnova.com,user_automacao03112014_090641049@cnova.com,user_automacao03112014_090641315@cnova.com,user_automacao03112014_090641595@cnova.com,user_automacao03112014_090641814@cnova.com,user_automacao03112014_090642048@cnova.com,user_automacao03112014_090643015@cnova.com,user_automacao03112014_090643265@cnova.com,user_automacao03112014_090643421@cnova.com,user_automacao03112014_090643935@cnova.com,user_automacao03112014_090648740@cnova.com,user_automacao03112014_090648584@cnova.com,user_automacao03112014_090642438@cnova.com,user_automacao03112014_090642609@cnova.com,user_automacao03112014_090642812@cnova.com,user_automacao03112014_090644357@cnova.com,user_automacao03112014_090644747@cnova.com,user_automacao03112014_090645012@cnova.com,user_automacao03112014_090645215@cnova.com,user_automacao03112014_090645433@cnova.com,user_automacao03112014_090647071@cnova.com,user_automacao03112014_090647321@cnova.com,user_automacao03112014_090647492@cnova.com,user_automacao03112014_090645620@cnova.com,user_automacao03112014_090645854@cnova.com,user_automacao03112014_090646088@cnova.com,user_automacao03112014_090646338@cnova.com,user_automacao03112014_090646447@cnova.com,user_automacao03112014_090646665@cnova.com,user_automacao03112014_090646806@cnova.com'
  create_address users, password, cep
end

E('crio um usuário via API - RegisterPage') do
  user = create_user_api
  $usuario_email = user["Salvar2Result"]["Email"]
end




