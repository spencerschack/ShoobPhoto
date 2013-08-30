class OrderObserver < ActiveRecord::Observer
  
  def after_save order
    #Receipts.deliver_receipt(order)
  end
end
