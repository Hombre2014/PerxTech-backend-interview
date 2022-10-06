module UsersHelper
  def points_per_purchase(user, purchase)
    if user.level == 1
      @total_amount_spent += purchase.amount
      @unused_amount += purchase.amount
      if @unused_amount >= 100
        user.points += @unused_amount.divmod(100)[0] * 10
        @unused_amount = @unused_amount.divmod(100)[1]
      end
    elsif user.level == 2 && user.country_of_origin != purchase.country_of_purchase
      @total_amount_spent += purchase.amount
      @unused_amount += purchase.amount
      user.points += @unused_amount.divmod(100)[0] * 20
      @unused_amount = @unused_amount.divmod(100)[1]
    else
      user.points += @unused_amount.divmod(100)[0] * 10
      @unused_amount = @unused_amount.divmod(100)[1]
    end
  end

  def earning_points(user)
    @purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc)
    @purchases_per_user.includes(:user).each do |purchase|
      points_per_purchase(user, purchase)
    end
  end
end
