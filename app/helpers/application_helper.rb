module ApplicationHelper

  def price_tag price
    raise 'price_tag is deprecated'
  end
  
  def number_to_currency number, options = {}
    options.reverse_merge! :show_zero => true
    options.reverse_merge! :precision => 3 if number < 100
    if number > 0 || options.delete(:show_zero)
      super(number.to_f/100, options) 
    end
  end
  
  def breadcrumbs *args
    links = args[0..-2].map do |text|
      link_to text.to_s.titleize, send("#{text.to_s.underscore}_path")
    end + [args[-1].to_s.titleize]
    links.join("<span class='right_arrow'></span>").html_safe
  end
  
  def render_table_rows hash, options = {}, &block
    sort_proc = options.delete :sort
    hash.keys.sort_by(&sort_proc).each do |node|
      block.call node, render_tree(hash[node], :sort => sort_proc, &block)
    end if hash.present?
  end
  
  def quantity_options minimum
    incrementer = case minimum
    when 1..5
      1
    when 6..20
      5
    when 21..100
      20
    when 101..1000
      100
    end
    (0..10).map{|no| no*incrementer+minimum} + ['Other']
  end
end
