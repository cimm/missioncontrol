class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice          = Invoice.new
    @invoice.number   = Invoice.next_number
    @selectable_units = @invoice.selectable_units
  end

  def create
    invoice = Invoice.new(params[:invoice])
    if invoice.save
      flash[:notice] = "Invoice added"
    else
      flash[:error] = "Invoice not added"
    end
    redirect_to(:action => "index")
  end

  def edit
    @invoice          = Invoice.find(params[:id])
    @selectable_units = @invoice.selectable_units
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update_attributes(params[:invoice])
    flash[:notice] = "Invoice updated"
    redirect_to(:action => "index")
  end
end
