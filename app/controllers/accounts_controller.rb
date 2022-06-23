class AccountsController < ApplicationController
  before_action :authenticate_account!

  def new
    redirect_to root_path unless current_account.unidentified?
  end
end
