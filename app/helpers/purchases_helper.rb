module PurchasesHelper
  def points_per_purchase(user, purchase)
    @points_per_purchase = 0
    case user.level
    when 1
      user.total_amount_spent += purchase.amount
      user.unused_amount += purchase.amount
      user.save
      if user.unused_amount >= 100
        user.points += user.unused_amount.divmod(100)[0] * 10
        user.save
        @points_per_purchase += user.unused_amount.divmod(100)[0] * 10
        user.unused_amount = user.unused_amount.divmod(100)[1]
        user.save
      end
      check_for_tier_change_level_one(user)
    when 2
      # past_purchase_year = first_purchase_year(user)
      if purchase.date.year == @year_of_purchase + 1
        user.points = 0
        user.save
        @year_of_purchase += 1
      end
      if user.country_of_origin == purchase.country_of_purchase
        user.total_amount_spent += purchase.amount
        user.unused_amount += purchase.amount
        user.points += user.unused_amount.divmod(100)[0] * 10
        user.save
        @points_per_purchase += user.unused_amount.divmod(100)[0] * 10
        user.unused_amount = user.unused_amount.divmod(100)[1]
      else
        user.total_amount_spent_foreign += purchase.amount
        user.unused_amount_foreign += purchase.amount
        user.points += user.unused_amount_foreign.divmod(100)[0] * 20
        user.save
        @points_per_purchase += user.unused_amount_foreign.divmod(100)[0] * 20
        user.unused_amount_foreign = user.unused_amount_foreign.divmod(100)[1]
      end
      user.save
      check_for_tier_change_level_two(user, purchase)
      purchases_per_user_per_quarter(user, purchase)
    else
      puts 'No points'
    end
    @points_per_purchase
  end
end
