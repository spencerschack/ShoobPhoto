class OrderMailer < ActionMailer::Base
  helper :application
  
  def receipt args
    @order = args
    @pictures = []
    @order.line_items.map{|line_item| line_item.data[:purchase_id] if line_item.data[:email_picture]}.compact.each do |purchase_id|
      file_path = Dir.glob("#{Rails.root}/assets/spring_portraits/#{purchase_id[0..2]}-?????#{purchase_id[3].chr}-#{purchase_id[4..9]}.jpg")
      if file_path.any?
        attachments["#{purchase_id}.jpg"] = File.read file_path[0]
        @pictures << "The picture for purchase id '#{purchase_id}' has been attached to this email."
      else
        @pictures << "The picture for purchase id '#{purchase_id}' could not be found. Please email us for more information."
      end
    end
    mail :to => args[:email], :from => 'info@example.com', :subject => 'Shoob Photography Order Receipt'
  end
end