class Github::RepositoriesController < ApplicationController
  before_action :set_github_repository, only: [:destroy]

  # GET /github/repositories
  def index
    @github_repositories = Github::Repository.all
  end

  # GET /github/repositories/new
  def new
    @github_repository = Github::Repository.new
  end

  # POST /github/repositories
  def create
    @github_repository = Github::Repository.new(github_repository_params)

    if @github_repository.save
      redirect_to @github_repository, notice: 'Repository was successfully created.'
    else
      render :new
    end
  end

  # DELETE /github/repositories/1
  def destroy
    @github_repository.destroy
    redirect_to github_repositories_url, notice: 'Repository was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_github_repository
      @github_repository = Github::Repository.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def github_repository_params
      params.require(:github_repository).permit(:owner, :repo)
    end
end
