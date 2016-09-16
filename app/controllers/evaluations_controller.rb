class EvaluationsController < ApplicationController
  before_action :set_crew_member
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]

  def index
    @evaluations = @crew_member.evaluations.all
  end

  def show
  end

  def new
    @evaluation = @crew_member.evaluations.new
  end

  def edit
  end

  def create
    @evaluation = @crew_member.evaluations.create(evaluation_params)

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to crew_member_evaluation_path(@crew_member, @evaluation), notice: 'Evaluation was successfully created.' }
        format.json { render :show, status: :created, location: @evaluation }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to crew_member_evaluation_path(@crew_member, @evaluation), notice: 'Evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to crew_member_evaluations_path(@crew_member), notice: 'Evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    def set_crew_member
      @crew_member = CrewMember.find(params[:crew_member_id])
    end

    def evaluation_params
      params.require(:evaluation).permit(:star_date, :assessment, :rating, :crew_member_id)
    end
end