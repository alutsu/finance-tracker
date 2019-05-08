class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "A ação #{@user_stock.stock.name} foi salvo ao seu portfólio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user, stock_id: stock.id).first
    if @user_stock.destroy
      flash[:success] = 'A ação foi deletada com sucesso.'
      redirect_to my_portfolio_path
    else
      flash[:danger] = 'Algo de errado ocorreu ao realizar esta ação'
      redirect_to my_portfolio_path
    end
  end
  
end
