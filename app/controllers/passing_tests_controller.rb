class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result gist]

  def show
  end

  def update
    @passing_test.accept!(answer_ids)

    if @passing_test.completed?
      TestsMailer.complited_test(@passing_test).deliver_now
      BadgeService.new(@passing_test).call
      redirect_to result_passing_test_path(@passing_test)
    else
      render :show
    end
  end

  def result
  end

  def gist
    result = GistQuestionService.new(@passing_test.current_question).call

    flash_options = if result
                      create_gist!(result.html_url)
                      { notice: result.html_url }
                    else
                      { alert: t('.failure') }
                    end
    redirect_to @passing_test, flash_options
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end

  def answer_ids
    params[:answer_ids] || []
  end

  def create_gist!(url)
    current_user.gists.create!(
      question: @passing_test.current_question,
      url: url
    )
  end
end
