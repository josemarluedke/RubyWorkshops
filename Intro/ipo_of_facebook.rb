#Encoding: UTF-8
text = %{O Facebook apresentou, na quarta-feira (1º), os documentos aos órgãos regulatórios para fazer uma oferta inicial de ações (o chamado IPO), prevista para maio, em que espera arrecadar US$ 5 bilhões. A expectativa do mercado é que o IPO seja o maior para uma empresa de internet, superando o de US$ 2 bilhões do Google, feita em agosto de 2004.

De acordo a estimativa de analistas, depois que as ações da empresa começarem a ser negociadas com o IPO, o valor de mercado da empresa pode chegar a um patamar entre US$ 75 bilhões e US$ 100 bilhões, o que colocaria o Facebook na sétima posição entre as empresas do setor de tecnologia das Américas, atrás dos gigantes Apple, Microsoft e IBM.

Na opinião de alguns especialistas, essa previsão de valor de mercado é exagerada. Se a estimativa se confirmar, no entanto, a empresa ainda deverá valer pouco mais de "meio Google": de acordo com levantamento feito pela consultoria Economatica a pedido do G1, a empresa de Larry Page e Sergey Brin encerrou o mês de janeiro valendo US$ 188 bilhões.

Com esta avaliação, o Facebook teria o segundo maior valor de mercado das Américas entre as empresas dedicadas à internet, atrás apenas do Google.}


actors = text.scan(/[A-Z][a-z]{3,}/).uniq
puts "Atores envolvidos na notícia: #{actors.join ', '}"
companies = %w[Facebook Google IBM Apple Microsoft]

found_companies = text.scan /#{companies.join("|")}/
puts "Empresas mais relevantes da notícia:"
companies.each { |company| puts "  #{company}: #{found_companies.count company}" }

values = text.scan /US\$ \d{1,3} bilhões/
puts "Valores envolvidos na notícia: #{values.join ', '}"

sequences_of_words = text.scan /\w{4,}/
puts "Palavras na notícia: #{sequences_of_words.count}"