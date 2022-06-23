class ApplicationController < ActionController::Base
  before_action :require_account_status, if: -> { account_signed_in? && current_account.unidentified? }

  private

    def require_account_status
      redirect_to new_account_path unless request.path == '/accounts/new' || request.path.include?('account')
    end
end
