#encoding: utf-8
#

@garantia = false
@seguro = false

E('verifico que estou na página de garantia estendida --ExtendedWarrantyPage') do
  expecting(extended_warranty.is_extended_warranty_page, true, 'Verifica que é a página de garantia estendida')
end

E('escolho minha opção de garantia estendida {string} --ExtendedWarrantyPage') do |garantiaEstendida|
  expecting(extended_warranty.has_warranty, true, 'Verifica se há garantia estendida para o produto especifico')
  extended_warranty.select_warranty garantiaEstendida
end
E('escolho minha opção de seguro {string} --ExtendedWarrantyPage') do |seguro|
  expecting(extended_warranty.has_insurance, true, 'Verifica se há seguro contra roubo para o produto especifico')
  extended_warranty.select_insurance seguro
  tracing "Seleciona o seguro #{seguro}"
end

E('escolho minhas opções de garantia estendida {string} e seguro {string} --ExtendedWarrantyPage') do |garantiaEstndida, seguro|
  extended_warranty.select_warranty_and_insurance garantiaEstndida, seguro
end

E('movo o produto para o carrinho --ExtendedWarrantyPage') do
  extended_warranty.click_continue
  tracing 'Move o produto da página de garantia estendida para a próxima página'
end

