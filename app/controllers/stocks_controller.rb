class StocksController < ApplicationController
  def search
    if params[:stock].blank?
      flash.now[:danger] = "A consulta não pode ser vazia!"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Por favor digite algum simbolo válido!" unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end
