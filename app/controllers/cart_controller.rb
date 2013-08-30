class CartController < ApplicationController
  before_filter :set_cart, :only => [:index, :add_package, :add_product, :purchase, :checkout]
  
  ssl_required :checkout, :purchase
  
  def index
  end

  def add_package
    params[:cart_package][:option_ids] = params[:cart_package][:option_ids].values unless params[:cart_package][:option_ids].blank?
    @cart_package = CartPackage.new params[:cart_package]
    if @cart_package.valid?
      @line_item = LineItem.create(
        :data => @cart_package.data,
        :price => @cart_package.price,
        :cart => @cart,
        :shipping => @cart_package.shipping)
      redirect_to cart_url
    else
      render 'catalog/package'
    end
  end
  
  def add_product
    @cart_product = CartProduct.new params[:cart_product]
    if @cart_product.valid?
      @line_item = LineItem.create(:data => @cart_product.data, :price => @cart_product.price, :cart => @cart)
      @line_item.create_file_upload(:file => params[:cart_product][:file])
      redirect_to cart_url
    else
      render 'catalog/printing_product'
    end
  end
  
  def destroy
    LineItem.find(params[:id]).destroy
    redirect_to cart_path
  end

  def checkout
    redirect_to(cart_url) unless @cart.line_items.any?
    @order = Order.new :price => @cart.price
  end
  
  def purchase
    @order = Order.new params[:order].merge(:price => @cart.price, :line_item_ids => @cart.line_item_ids)
    if @order.save
      OrderMailer.receipt(@order).deliver
      session[:order_id] = @order.id
      session[:purchasing] = false
      redirect_to cart_receipt_url
    else
      logger.debug "[order save error] #{@order.errors.full_messages.join(', ')}"
      session[:purchasing] = false
      render 'checkout'
    end
  end

  def receipt
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      redirect_to cart_url
    end
  end
  
  private
  
  def set_cart
    begin
      raise if session[:cart_id].blank?
      @cart = Cart.find(session[:cart_id])
    rescue
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

end
