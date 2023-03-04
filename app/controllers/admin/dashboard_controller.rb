# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    def index
      @customers = Customer.top_customers
      @invoices = InvoiceItem.incomplete_invoices
    end
  end
end
