class UniversitiesController < ApplicationController
  before_action :set_university, only: [:show]

  def index
    @universities = University.active
  end

  def show; end

  private

    def set_university
      @university = University.find(params[:id])
    end
end
