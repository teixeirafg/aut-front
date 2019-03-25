
[1mFrom:[0m C:/Users/aluga.com/Documents/Projetos Automacao/vv-aut-front/features/support/utils/commons.rb @ line 81 Commons#into_frame:

    [1;34m74[0m: [32mdef[0m [1;34minto_frame[0m(id_frame)
    [1;34m75[0m:   [1;34;4mWaitPage[0m.new
    [1;34m76[0m:   retries = [1;34m0[0m
    [1;34m77[0m:   [32mbegin[0m
    [1;34m78[0m:     puts [31m[1;31m'[0m[31mpassou por aqui[1;31m'[0m[31m[0m
    [1;34m79[0m:     page.driver.browser.switch_to.frame(id_frame)
    [1;34m80[0m:   [32mrescue[0m [1;34;4mSelenium[0m::[1;34;4mWebDriver[0m::[1;34;4mError[0m::[1;34;4mNoSuchFrameError[0m
 => [1;34m81[0m:     binding.pry
    [1;34m82[0m:     retries += [1;34m1[0m
    [1;34m83[0m:     [32mif[0m retries <= [1;34m3[0m
    [1;34m84[0m:       [32mretry[0m
    [1;34m85[0m:     [32melse[0m
    [1;34m86[0m:       tracing_error [31m[1;31m"[0m[31mFrame: ''#{id_frame}[0m[31m'' não encontrado[1;31m"[0m[31m[0m
    [1;34m87[0m:     [32mend[0m
    [1;34m88[0m:   [32mend[0m
    [1;34m89[0m: [32mend[0m

