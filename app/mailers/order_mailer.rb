class OrderMailer < ActionMailer::Base
  default from: "jsack777@gmail.com"

  def submit_order(order)
    @order = order
    @sandwiches = @order.sandwiches
    order_text = "Order number #{@order.id}\n"
    @sandwiches.each_with_index do |sandwich, idx|
      order_text += "#{idx+1}. \
#{sandwich.ingredients.present? ? sandwich.ingredients.collect{|ingredient| ingredient.name}.join(", ") : "nothing"}"
      order_text += "\n on #{sandwich.container.name}\n\n" if sandwich.container
      order_text += SnappyQuote.get_one
    end
    mail(:to => order.user.email, :subject => "Order Confirmation") do |format|
      format.html { render :partial => 'sandwiches/list' }
      format.text { render :text => order_text }
    end
  end

end
