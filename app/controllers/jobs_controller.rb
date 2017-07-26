class JobsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :job, only: %i[show edit update]
  before_action :companies, only: %i[new edit]

  def index
    @jobs = Job.all
    @companies = Company.all
    @categories = Category.all
  end

  def show; end

  def new
    @job = Job.new
  end

  def edit; end

  def create
    @job = current_user.jobs.new job_params
    if @job.save
      redirect_to @job
    else
      flash[:error] = 'Não foi possível criar a vaga'
      render :new
    end
  end

  def update
    if @job.update job_params
      redirect_to @job
    else
      flash[:error] = 'Não foi possível atualizar a vaga'
      render :edit
    end
  end

  def my_jobs
    @jobs = current_user.jobs
  end

  private

  def job_params
    params.require(:job).permit(:title, :location, :category_id, :company_id,
                                :description, :featured, :hiring_type)
  end

  def job
    @job = Job.find params[:id]
  end

  def companies
    @companies = current_user.companies
  end
end
