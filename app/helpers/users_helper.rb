module UsersHelper
  def points_per_purchase(user, purchase)
    @points_per_purchase = 0
    if user.level == 1 then
      @total_amount_spent += purchase.amount
      @unused_amount += purchase.amount
      if @unused_amount >= 100
        user.points += @unused_amount.divmod(100)[0] * 10
        user.save
        @points_per_purchase += @unused_amount.divmod(100)[0] * 10
        @unused_amount = @unused_amount.divmod(100)[1]
      end
    elsif user.level == 2 then
      if user.country_of_origin != purchase.country_of_purchase
        @total_amount_spent_foreign += purchase.amount
        @unused_amount_foreign += purchase.amount
        user.points += @unused_amount_foreign.divmod(100)[0] * 20
        user.save
        @points_per_purchase += @unused_amount_foreign.divmod(100)[0] * 20
        @unused_amount_foreign = @unused_amount_foreign.divmod(100)[1]
      else
        @total_amount_spent += purchase.amount
        @unused_amount += purchase.amount
        user.points += @unused_amount.divmod(100)[0] * 10
        user.save
        @points_per_purchase += @unused_amount.divmod(100)[0] * 10
        @unused_amount = @unused_amount.divmod(100)[1]
      end
    end
    @points_per_purchase
  end

  def earning_points(user)
    purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc)
    purchases_per_user.each do |purchase|
      if !purchase.processed_for_points
        points_per_purchase(user, purchase)
        purchase.processed_for_points = true
        purchase.save
      end
    end
  end

  def check_spending_one_month(user, purchase, purchase_month, purchase_year)
    @points_per_month += points_per_purchase(user, purchase)
    if @points_per_month >= 100
      Reward.create(user_id: user.id, name: 'Spent 100 points in a month. Received Free Coffee', date: purchase.date)
      user.points -= 100
      user.save
      @points_per_month -= 100
    end
  end

  def rewards(user)
    if user.level == 1
      purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc)
      purchase_month = purchases_per_user.first.date.mon
      purchase_year = purchases_per_user.first.date.year
      purchases_per_user.each do |purchase|
        if !purchase.counted
          if purchase_month == purchase.date.mon && purchase_year == purchase.date.year
            check_spending_one_month(user, purchase, purchase_month, purchase_year)
          else
            @points_per_month = 0
            purchase_month = purchase.date.mon
            purchase_year = purchase.date.year
            if purchase_month == purchase.date.mon && purchase_year == purchase.date.year
              check_spending_one_month(user, purchase, purchase_month, purchase_year)
            end
          end
          purchase.counted = true
          purchase.save
        end
        purchase_month = purchase.date.mon
        purchase_year = purchase.date.year
      end
    elsif user.level == 2
      month_of_birth = user.birthday.mon
      today_month = Date.today.mon
      user_age = Date.today.year - user.birthday.year
      if !user.birthday_reward
        if month_of_birth > today_month
          Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee', date: user.birthday + (user_age - 1).years)
          user.birthday_reward = true
          user.save
        else
          Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee', date: user.birthday + (user_age - 1).years)
          Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee', date: user.birthday + user_age.years)
          user.birthday_reward = true
          user.save
        end
      end
    end
  end
end
