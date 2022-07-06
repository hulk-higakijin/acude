class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :set_profile, only: %i[ show update edit ]
  before_action :require_profile, if: -> { current_account.unidentified? }, only: %i[show]

  def show; end

  def new
    redirect_to root_path unless current_account.unidentified?
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

  def edit; end

  def update
    @profile.update!(profile_params)
    redirect_to profile_path
  end

  private

    def set_profile
      @profile = current_account.profile
    end

    def profile_params
      params.require(:profile).permit(:name, :introduction)
    end

    def require_profile
      redirect_to new_profile_path
    end
end
