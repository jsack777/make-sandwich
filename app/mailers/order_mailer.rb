class OrderMailer < ActionMailer::Base
  default from: ENV['GMAIL_SMTP_USER']
  default bcc: ENV['GMAIL_SMTP_USER']

  def submit_order(order)
    @order = order
    @sandwiches = @order.sandwiches

    order_text = "Here is another sandwich Order!\n\n"
    order_text += "#{@order.user.display_name} would like the following Please!\n\n"
    @sandwiches.each_with_index do |sandwich, idx|
      order_text += "#{idx+1}. \
#{sandwich.ingredients.present? ? sandwich.ingredients.collect_names : "nothing"}"
      order_text += "\n in a #{sandwich.container.name}\n\n" if sandwich.container
    end

    order_text += "A Snappy quote from our friends at http://www.iheartquotes.com/\n\n"
    order_text += SnappyQuote.get_one

    cc = ENV['GT_MAILBOX'] if order.user.email.match(/generalthings/)

    mail(to: order.user.email, cc: cc, subject: "Order Confirmation") do |format|
      format.html { render 'order_mailer/sandwich_order' }
      format.text { render :text => order_text }
    end
  end

end
