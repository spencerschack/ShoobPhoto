class OrdersController < ApplicationController
  
  filter_resource_access

  def index
    
    @orders = if params[:format] == 'csv'
      Order.includes(:line_items)
    else
      Order
    end
    
    @orders = if params[:search].blank?
      @orders.all
    else
      @orders.search(params[:search])
    end
    
    respond_to do |format|
      
      format.html
      
      format.csv do
        
        require 'csv'
        
        csv_file = ''
        
        if params[:context] == 'students'
          
          line_item_columns = {}
          @orders.each do |order|
            order.line_items.each do |line_item|
              line_item.data.each_key do |key|
                line_item_columns[key] = true
              end
            end
          end
          line_item_columns = line_item_columns.keys
            
          headers = @orders.first.attributes.keys
          headers << 'Price'
          headers += line_item_columns
          csv_file << CSV.generate_line(headers.map{ |h| h.to_s.titleize }) + "\n"
          
          @orders.each do |order|
            order.line_items.each do |line_item|
              
              values = order.attributes.values
              values << line_item.price
              
              values += line_item_columns.map do |column|
                line_item.data[column]
              end
              
              csv_file << CSV.generate_line(values) + "\n"
            end
          end
          
        else
        
            csv_file << CSV.generate_line(@orders.first.attributes.keys.map{|column| column.titleize} + ['Line Items']) + "\n"
            @orders.each do |order|
              csv_file << CSV.generate_line(order.attributes.values + [
                order.line_items.map do |line_item|
                  ["Price: #{line_item.price}"].push(
                    line_item.data.map do |key, value|
                      "#{key.to_s.titleize}: #{value}"
                    end
                  ).join("\n")
                end.join("\n\n")
              ]) + "\n"
            end
        
        end
        
        send_data csv_file, :type => 'text/csv'
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, :notice => 'Order was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url
  end
  
  def resend_receipt
    @order = Order.find params[:id]
    if OrderMailer.receipt(@order).deliver
      flash[:notice] = 'Receipt was sent.'
    else
      flash[:error] = 'Receipt could not be sent.'
    end
    redirect_to @order
  end
end
