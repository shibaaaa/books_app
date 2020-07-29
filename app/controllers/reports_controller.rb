# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
    current_user.reports.find(params[:id])
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("reports.created.notice")
    else
      render :new
    end
  end

  def update
    if @report = current_user.reports.find(params[:id])
      @report.update(report_params)
      redirect_to @report, notice: t("reports.updated.notice")
    else
      render :edit
    end
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy
    redirect_to reports_url, notice: t("reports.destroy.notice")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :content, :user_id)
    end
end
