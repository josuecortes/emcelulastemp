module ApplicationHelper
	#include ScopedSearch::Helpers

	def titulo_pagina(titulo,sub_titulo)
    html = ""
    html2 = ""
    html += "#{titulo}"
    html2 += "#{sub_titulo}"

    content_for :titulo do
      raw(html)
    end

    content_for :sub_titulo do
      raw(html2)
    end

  end
  
	def detalhes(objeto)
	  if objeto	!= ""
	    return raw(objeto)
	  else
	    return raw("Nada Cadastrado")
	  end
	end

	def simnao(objeto)
	  if objeto	!= true
	    return raw('NÃO')
	  else
	    return raw("SIM")
	  end
	end

	def detalhes2(objeto,atributo)
	  if !objeto.nil? 
	    return objeto.send("#{atributo.to_s}")
	  else
	    return raw("Nada Cadastrado")
	  end
	end

	def link_icone(texto)
    case texto
	    when 'detalhes'
	      html="<i class='fa fa-eye'></i> Detalhes"

	    when 'editar'
	      html="<i class='fa fa-edit'></i> Editar"

	    when 'apagar'
	      html="<i class='fa fa-trash-o fa fa-white'></i> Apagar"

	    when 'excluir'
	      html="<i class='fa fa-close'></i> Excluir"

	    when 'remover'
	      html="<i class='fa fa-close'></i> Remover"

	    when 'desativar'
	      html="<i class='fa fa-close'></i> Desativar"

	    when 'salvar'
	      html="<i class='fa fa-hdd'></i> Salvar"

	    when 'voltar'
	      html="<i class='fa fa-arrow-left'></i> Voltar"

	    when 'cancelar'
	      html="<i class='fa fa-refresh'></i> Cancelar"

	    when 'resetar'
	      html="<i class='fa fa-repeat'></i> Resetar Senha"

	    when 'novo'
	      html="<i class='fa fa-plus'></i> Novo"

	    when 'nova'
	      html="<i class='fa fa-plus'></i> Nova"

	    when 'adicionar'
	      html="<i class='fa fa-plus'></i> Adicionar"

	    when 'ativar'
	      html="<i class='fa fa-check'></i> Ativar"

	    when 'pegar'
	      html="<i class='fa fa-smile-o'></i> Tornar-se Responsável"

	    when 'setar'
	      html="<i class='fa fa-reply-all'></i> Setar Tecnico"

	    when 'gerenciar'
	      html="<i class='fa fa-cog'></i> Gerenciar"

	    when 'trilhos'
	      html="<i class='fa fa-cog'></i> Trilhos"

	    when 'relatorios'
	      html="<i class='fa fa-folder-open'></i> Relatórios"

	    when 'enviar'
	      html="<i class='fa fa-arrow-right'></i> Enviar"

	    when 'logar'
	      html="<i class='fa fa-arrow-right'></i> Logar"  

	    when 'receber'
	      html="<i class='fa fa-arrow-left'></i> Receber"

	  end
	  
	  return raw(html)
	end

	def icone_permissao(texto)
		html = ""
		case texto
			when 'MASTER'
				html+="MT "

			when 'ADMINISTRADOR'
				html+="AD "

			when 'PRESIDENTE'
				html+="PD "	

			when 'PASTOR'
				html+="PR "

			when 'CORDENADOR DE CELULA'
				html+="CC "

			when 'SUPERVISOR DE CELULA'
				html+="SC "

			when 'LIDER DE CELULA'
				html+="LC "

			when 'SECRETARIA'
				html+="ST "

		end

		return raw(html)

	end

	def no_mes(mes)

		html = ""
		case mes
			when 1
				html+=" de JANEIRO "

			when 2
				html+=" de FEVEREIRO"

			when 3
				html+=" de MARÇO"

			when 4
				html+=" de ABRIL"
	
			when 5
				html+=" de MAIO"

			when 6
				html+=" de JUNHO"
	
			when 7
				html+=" de JULHO"

			when 8
				html+=" de AGOSTO"
			
			when 9
				html+=" de SETEMBRO"

			when 10
				html+=" de OUTUBRO"

			when 11
				html+=" de NOVEMBRO"
			
			when 12
				html+=" de DEZEMBRO"

			else 
				html+=" ATUAL"
	
		end

		return raw(html)

	end

	def na_semana(dia)

		html = ""
		case dia
			when '1'
				html+=" SEGUNDA "

			when '2'
				html+=" TERÇA "

			when '3'
				html+=" QUARTA "

			when '4'
				html+=" QUINTA "

			when '5'
				html+=" SEXTA "
	
			when '6'
				html+=" SABADO "

			when '0'
				html+=" DOMINGO "
	
			else 
				html+=" ATUAL"
	
		end

		return raw(html)

	end

end
