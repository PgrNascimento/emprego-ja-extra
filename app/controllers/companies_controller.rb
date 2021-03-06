class CompaniesController < ApplicationController
  before_action :company, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[new create edit update]

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = current_user.companies.new company_params
    if @company.save
      redirect_to @company
    else
      flash[:error] = 'Não foi possível criar a empresa'
      render :new
    end
  end

  def edit; end

  def update
    if @company.update company_params
      redirect_to @company
    else
      flash[:error] = 'Não foi possível atualizar a empresa'
      render :edit
    end
  end

  def my_companies
    @companies = current_user.companies
  end

  private

  def company_params
    params.require(:company).permit(:name, :location, :phone, :mail)
  end

  def company
    @company = Company.find params[:id]
  end
end
