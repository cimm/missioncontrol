require "date_range"

class ExpensesController < ApplicationController
  def index
    if params[:date_range]
      date_range = DateRange.new(params[:date_range])
      @expenses  = Expense.within_date_range(date_range.start_date, date_range.end_date)
    else
      @expenses = Expense.all
    end
  end

  def new
    @expense        = Expense.new
    @expense.number = Expense.next_number
  end

  def create
    @expense = Expense.new(params[:expense])
    if @expense.save
      redirect_to expenses_path, :notice => "Expense added"
    else
      flash[:error] = "Expense not added"
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    expense = Expense.find(params[:id])
    expense.update_attributes(params[:expense])
    flash[:notice] = "Expense updated"
    redirect_to(:action => "index")
  end
end
