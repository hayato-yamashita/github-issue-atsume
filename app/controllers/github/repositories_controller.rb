class Github::RepositoriesController < ApplicationController
  before_action :set_repository, only: [:destroy, :fetch]
  before_action :set_repository_with_issues, only: [:show]

  # GET /github/repositories
  def index
    @repositories = Github::Repository.all
  end

  # GET /github/repositories/1
  def show
  end

  # GET /github/repositories/new
  def new
    @repository = Github::Repository.new
  end

  # POST /github/repositories
  def create
    @repository = Github::Repository.new(repository_params)

    if @repository.save
      redirect_to root_url, notice: t('.success')
    else
      render :new
    end
  end

  # DELETE /github/repositories/1
  def destroy
    if @repository.destroy
      redirect_to root_url, notice: t('.success')
    else
      redirect_to root_url, alert: @repository.errors.full_messages[0]
    end
  end

  # POST /github/repositories/1/fetch
  def fetch
    if @repository.refresh_issues
      redirect_to @repository, notice: t('.success')
    else
      redirect_to @repository, alert: t('.failure')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Github::Repository.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_repository_with_issues
      @repository = Github::Repository.eager_load(:issues).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def repository_params
      params.require(:github_repository).permit(:owner, :repo)
    end
end
