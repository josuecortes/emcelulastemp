# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
	before_filter :authenticate_user!
	
  def index
  end

  def nao_autorizado
  end

end
