class RelatoriosController < ApplicationController

  def index

    authorize! :show, :relatorios

  	#if can?(:relatorios, :all)
  	#end

  end

  def aniversariantes

    authorize! :aniversariantes, :relatorios

  	# if params[:q] == "" or params[:q] == nil
  	# 	@search = Pessoa.where(:mes => DateTime.now.month).search(params[:q])
  	# else
  	# 	@search = Pessoa.search(params[:q])
  	# end

  	# @pessoas = @search.result(distinct: true)


    # @semana = @search.result(distinct: true)
    # DA VIEW - >>>>   @pessoas.order_by([:dia, 'asc']).each do |pessoa|

    if params[:mes].blank?
      data = DateTime.now
      @mes = data.month
    else
      data = "01/#{params[:mes]}/#{DateTime.now.year}".to_date
      @mes = data.month
    end

    @nesta_semana = []
    @neste_mes = []

    @casamento_nesta_semana = []
    @casamento_neste_mes = []

    Pessoa.all.each do |p|
      if !p.data_nascimento.blank?

        aniversario = "#{p.data_nascimento.day}/#{p.data_nascimento.month}/#{DateTime.now.year}".to_date
        #if aniversario >= DateTime.now.beginning_of_week(start_day = :monday) and aniversario <= DateTime.now.end_of_week(end_day = :sunday)
        if aniversario >= DateTime.now.beginning_of_week - 1.days and aniversario <= DateTime.now.end_of_week - 1.days
          @nesta_semana << p
        end

        if p.data_nascimento.month == @mes
          @neste_mes << p
        end

      end

      if !p.data_casamento.blank? and p.estado_civil == "CASADO(A)"

        casamento = "#{p.data_casamento.day}/#{p.data_casamento.month}/#{DateTime.now.year}".to_date
        #if aniversario >= DateTime.now.beginning_of_week(start_day = :monday) and aniversario <= DateTime.now.end_of_week(end_day = :sunday)
        if casamento >= DateTime.now.beginning_of_week - 1.days and casamento <= DateTime.now.end_of_week - 1.days
          @casamento_nesta_semana << p
        end

        if p.data_casamento.month == @mes
          @casamento_neste_mes << p
        end

      end  


    end

    @meses = [["Janeiro",1],
    ["Fevereiro",2],
    ["Março",3],
    ["Abril",4],
    ["Maio",5],
    ["Junho",6],
    ["Julho",7],
    ["Agosto",8],
    ["Setembro",9],
    ["Outubro",10],
    ["Novembro",11],
    ["Dezembro",12]]

  end

  def geral

    authorize! :geral, :relatorios

    @pessoas = Pessoa.all
    @pessoas_sem_celula = Pessoa.pessoas_sem_celula

    @em_treinamento = Pessoa.where(:celula_que_e_lider_em_treinamento_id.ne=>nil)
    @lideres = Pessoa.where(:celulas_que_e_lider_ids.ne=>[])
    @supervisores = Pessoa.where(:celulas_que_e_supervisor_ids.ne=>[])
    @cordenadores = Pessoa.where(:celulas_que_e_cordenador_ids.ne=>[])

    @celulas = Celula.all
    @celulas_ativas = Celula.where(:ativo=>true)
    @celulas_inativas = Celula.where(:ativo=>false)

  end


end
