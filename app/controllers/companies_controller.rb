class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def show
    @company = Company.find params[:id]
  end

  def create
    @company = Company.new company_params
    if @company.save
      redirect_to @company
    else
      flash[:error] = "Não foi possível criar a empresa"
      render :new
    end
  end

  def edit
    @company = Company.find params[:id]
  end

  def update
    @company = Company.find params[:id]
    if @company.update company_params
      redirect_to @company
    else
      flash[:error] = "Não foi possível atualizar a empresa"
      render :edit
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :location, :phone, :mail)
  end
end
