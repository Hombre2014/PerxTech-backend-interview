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

  def if_rewards?(user)
    if user.level == 1
      @purchases_per_user.each do |purchase|
        purchase_month = Purchase.where(user_id: user.id).where(purchase.date.mon).first
        purchase_year = Purchase.where(user_id: user.id).where(purchase.date.year).first
        if purchase_month == purchase.date.mon && purchase_year == purchase.date.year
          points_per_purchase(user, purchase)
          if user.point >= 100
            
          end
        end
      end
    end
  end
end
