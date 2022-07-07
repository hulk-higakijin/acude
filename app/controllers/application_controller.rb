class ApplicationController < ActionController::Base
  before_action :require_profile, if: -> { account_signed_in? && current_account.unidentified? }

  private

    def require_profile
      redirect_to new_profile_path unless request.path.include?('account')
    end
end
