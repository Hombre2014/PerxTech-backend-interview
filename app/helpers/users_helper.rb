module UsersHelper
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def check_for_tier_change_level_one(user)
    if user.points >= 1000 && user.points < 5000
      user.tier = 'Gold'
      user.save
    elsif user.points >= 5000
      user.tier = 'Platinum'
      user.save
    end
  end

  def purchases_per_user_per_quarter(user, purchase)
    # quarter = (purchase.date.beginning_of_quarter..purchase.date.end_of_quarter)
    quarter_number = (purchase.date.month / 3.0).ceil
    year = purchase.date.year
    if (purchase.date.month / 3.0).ceil == quarter_number && purchase.date.year == year
      @spending_per_quarter += purchase.amount
    end
    return unless @spending_per_quarter >= 2000

    user.points += 100
    user.save
    @spending_per_quarter = 0
  end

  def check_for_tier_change_level_two(user, purchase)
    if user.tier == 'Standard' && user.points >= 1000 && user.points < 5000
      user.tier = 'Gold'
      Reward.create(user_id: user.id, date: purchase.date, name: '4x Airport Lounge Access')
      user.save
    elsif user.tier == 'Gold' && user.points >= 5000
      user.tier = 'Platinum'
      user.save
    end
  end

  def first_purchase_year(user)
    purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc).all
    @purchase_year = Purchase.where(user_id: user.id).order(date: :asc).first.date.year
    # @purchase_month = Purchase.where(user_id: user.id).order(date: :asc).first.date.month
  end

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

  def earning_points(user)
    purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc)
    purchases_per_user.each do |purchase|
      next if purchase.processed_for_points

      points_per_purchase(user, purchase)
      purchase.processed_for_points = true
      purchase.save
    end
  end

  def check_spending_one_month(user, purchase, _purchase_month, _purchase_year)
    @points_per_month += points_per_purchase(user, purchase)
    return unless @points_per_month >= 100

    Reward.create(user_id: user.id, name: 'Accumulate 100 points in a month. Received Free Coffee', date: purchase.date)
    user.points -= 100
    user.save
    @points_per_month -= 100
  end

  def rewards(user)
    case user.level
    when 1
      # first_purchase_year(user)
      purchases_per_user = Purchase.where(user_id: user.id).order(date: :asc)
      purchase_month = purchases_per_user.first.date.mon
      purchase_year = purchases_per_user.first.date.year
      purchases_per_user.each do |purchase|
        unless purchase.counted
          if purchase_month == purchase.date.mon && purchase_year == purchase.date.year
            check_spending_one_month(user, purchase, purchase_month, purchase_year)
          else
            @points_per_month = 0
            purchase_month = purchase.date.mon
            purchase_year = purchase.date.year
            # rubocop:disable Metrics/BlockNesting
            if purchase_month == purchase.date.mon && purchase_year == purchase.date.year
              check_spending_one_month(user, purchase, purchase_month, purchase_year)
            end
            # rubocop:enable Metrics/BlockNesting
          end
          purchase.counted = true
          purchase.save
        end
        purchase_month = purchase.date.mon
        purchase_year = purchase.date.year
      end
    when 2
      earning_points(user)
      month_of_birth = user.birthday.mon
      today_month = Date.today.mon
      user_age = Date.today.year - user.birthday.year
      unless user.birthday_reward
        if month_of_birth <= today_month
          Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee',
                        date: user.birthday + user_age.years)
        end
        Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee',
                      date: user.birthday + (user_age - 1).years)
        Reward.create(user_id: user.id, name: 'Birthday month reward. Received Free Coffee',
                      date: user.birthday + (user_age - 2).years)
        user.birthday_reward = true
        user.save
      end
    else
      puts 'No rewards'
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
