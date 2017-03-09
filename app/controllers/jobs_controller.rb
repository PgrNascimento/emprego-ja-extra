class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find params[:id]
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    if @job.save
      redirect_to @job
    else
      flash[:error] = "Não foi possível criar a vaga"
      render :new
    end
  end

  private
  def job_params
    params.require(:job).permit(:title, :location, :category, :company_id, :description, :featured)
  end
end
