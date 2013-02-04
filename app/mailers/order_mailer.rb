class OrderMailer < ActionMailer::Base
  default from: "jsack777@gmail.com"
  default bcc: "jsack777@gmail.com"
  default to: "make_sandwich@generalthings.com"

  def submit_order(order)
    @order = order
    @sandwiches = @order.sandwiches

    order_text = "Here is another sandwich Order!\n\n"
    @sandwiches.each_with_index do |sandwich, idx|
      order_text += "#{idx+1}. \
#{sandwich.ingredients.present? ? sandwich.ingredients.collect_names : "nothing"}"
      order_text += "\n in a #{sandwich.container.name}\n\n" if sandwich.container
    end

    order_text += "A Snappy quote from our friends at http://www.iheartquotes.com/\n\n"
    order_text += SnappyQuote.get_one

    mail(:cc => order.user.email, :subject => "Order Confirmation") do |format|
      format.html { render 'order_mailer/sandwich_order' }
      format.text { render :text => order_text }
    end
  end

end
