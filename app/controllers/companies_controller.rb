class CompaniesController < ApplicationController
  before_action :get_company, only: [:show, :edit, :update]

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = Company.new company_params
    if @company.save
      redirect_to @company
    else
      flash[:error] = "Não foi possível criar a empresa"
      render :new
    end
  end

  def edit; end

  def update
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

  def get_company
    @company = Company.find params[:id]
  end
end
