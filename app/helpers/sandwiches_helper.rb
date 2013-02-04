module SandwichesHelper

  def container_selected?(id)
    container_id = params[:container]
    container_id ||= @sandwich.container.id if @sandwich.container
    container_id.to_i == id
  end

  def ingredient_included?(id)
    ingredient_ids = params[:ingredients]
    ingredient_ids ||= @sandwich.ingredients.map{|i| i.id.to_s if i}.compact
    ingredient_ids.include?(id.to_s)
  end

  def ingredient_id(id)
    "i#{id}"
  end

  def no_sandwiches?
    @sandwiches.blank? ? true : @sandwiches.length == 0
  end

end
