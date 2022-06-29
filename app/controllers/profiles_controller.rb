class ProfilesController < ApplicationController
  before_action :authenticate_account!

  def show
    ## professorのロジックも考える
    @candidate = current_account.candidate
  end

  def new
    redirect_to root_path unless current_account.unidentified?
    @account = current_account
  end

  def create
    case params[:status]
    when 'professor'
      current_account.create_professor!(profile_params)
    when 'candidate'
      current_account.create_candidate!(profile_params)
    end

    redirect_to root_path
  end

  private

    def profile_params
      params.require(:account).permit(:name, :introduction)
    end
end
