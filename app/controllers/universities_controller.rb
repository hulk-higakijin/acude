class UniversitiesController < ApplicationController
  before_action :set_prefecture, only: [:index]
  before_action :set_university, only: [:show]

  def index
    @universities = @prefecture ? @prefecture.universities.active : University.active
  end

  def show; end

  private

    def set_prefecture
      @prefecture = Prefecture.find_by(id: params[:prefecture_id])
    end

    def set_university
      @university = University.find(params[:id])
    end
end
