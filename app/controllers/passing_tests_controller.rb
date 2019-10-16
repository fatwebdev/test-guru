class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result]

  def show
  end

  def update
    @passing_test.accept!(answer_ids)

    if @passing_test.completed?
      TestsMailer.complited_test(@passing_test).deliver_now
      redirect_to result_passing_test_path(@passing_test)
    else
      render :show
    end
  end

  def result
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end

  def answer_ids
    params[:answer_ids] || []
  end
end
