class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(bulk_discount_params[:id])
  end
  
  def new
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(bulk_discount_params[:merchant_id])
    @new_bulk_discount = BulkDiscount.new(bulk_discount_params)
    
    if @new_bulk_discount.percentage_discount < 0
      @new_bulk_discount.errors.add(:percentage_discount, "cannot have a negative value")
      flash[:errors] = @new_bulk_discount.errors.full_messages.last
      redirect_to new_merchant_bulk_discount_path(@merchant.id)
    else
      @new_bulk_discount = @merchant.bulk_discounts.create(
        promo_name: bulk_discount_params[:promo_name], 
        percentage_discount: (bulk_discount_params[:percentage_discount].to_f / 100), 
        quantity_threshold: bulk_discount_params[:quantity_threshold]
      )
      if @new_bulk_discount.save
        redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
        flash[:success] = "Your input has been saved."
      else
        redirect_to new_merchant_bulk_discount_path(@merchant.id)
        flash[:error] = "Please check your entries and try again."
      end
    end
  end
  
  def edit
#     merchant = Merchant.find(bulk_discount_params[:merchant_id])
#     <nav class="navbar navbar-expand-lg navbar-light bg-light">
#     <p class="navbar-text"><%= @merchant.name %></p>
#     <ul class="nav navbar-nav">
#       <li><%= link_to 'Dashboard', merchant_dashboard_index_path, style: 'pull-right' %>
#       <%= link_to 'My Items', merchant_items_path(@merchant), style: 'pull-right' %>
#       <%= link_to 'My Invoices', merchant_invoices_path(@merchant), style: 'pull-right' %></li>
#     </ul>
#   </nav>
# </div>

# <section id="new_bulk_discount_form">
#   <%= form_with url: merchant_bulk_discounts_path(@merchant.id), class: 'bulk_discount_form', method: :post, local: true do |f| %>
#     <%= f.label :promo_name, "Promo Name:" %>
#     <%= f.text_field :promo_name%><br/><br/>
#     <%= f.label :percentage_discount, "Discount Percentage:" %>
#     <%= f.number_field :percentage_discount, in: 1.0..100.0, min: 0 %>%<br/><br/>
#     <%= f.label :quantity_threshold, "Quantity Threshold:" %>
#     <%= f.number_field :quantity_threshold, min: 1 %><br/><br/>
#     <%= f.submit 'Submit'%>
#   <% end %>
# </section>
  
  end

  def destroy
    merchant = Merchant.find(bulk_discount_params[:merchant_id])
    merchant.bulk_discounts.destroy(bulk_discount_params[:id])

    redirect_to merchant_bulk_discounts_path(bulk_discount_params[:merchant_id])
  end

  private
      
  def bulk_discount_params
    params.permit(
      :promo_name,
      :percentage_discount,
      :quantity_threshold,
      :id,
      :merchant_id
    )
  end
end
