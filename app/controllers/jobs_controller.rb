class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :get_job, only: [:show, :edit, :update]

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
      flash[:error] = "Não foi possível criar a vaga"
      render :new
    end
  end

  def update
    if @job.update job_params
      redirect_to @job
    else
      flash[:error] = "Não foi possível atualizar a vaga"
      render :edit
    end
  end

  private
  def job_params
    params.require(:job).permit(:title, :location, :category_id, :company_id,
                                :description, :featured, :hiring_type)
  end

  def get_job
    @job = Job.find params[:id]
  end
end
