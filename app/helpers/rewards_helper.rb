module RewardsHelper
  def check_5_percent_reward
    @level_2_users = User.where(level: 2)
    @level_2_users.each do |user|
      @big_purchases = Purchase.where(user_id: user.id, amount: 100..1000).order(date: :asc).all
      @big_purchases.each do |purchase|
        next if purchase.checked_for_5_percent_rewards

        @number_of_big_purchases += 1 if purchase.amount >= 100
        if @number_of_big_purchases >= 10
          @reward = Reward.new(user_id: user.id, date: purchase.date, name: '5% Cash Rebate')
          @reward.save
          @number_of_big_purchases = 0
        end
        purchase.checked_for_5_percent_rewards = true
        purchase.save
      end
    end
  end

  def free_movie_tickets_reward(users_level_two)
    users_level_two.each do |user|
      @total_amount_for_movie_tickets = 0
      first_purchase = Purchase.where(user_id: user.id).order(date: :asc).first
      first_purchase_date = first_purchase.date
      all_purchases_within_2_months =
        Purchase.where(user_id: user.id, date:
          first_purchase_date..(first_purchase_date + 60.days)).order(date: :asc).all
      all_purchases_within_2_months.each do |purchase|
        if !purchase.checked_for_free_movie_tickets
          @total_amount_for_movie_tickets += purchase.amount
          if @total_amount_for_movie_tickets >= 1000
            @free_movie_tickets = Reward.create(user_id: user.id, date: purchase.date, name: 'Free Movie Tickets').save
            @total_amount_for_movie_tickets = 0
          end
          purchase.checked_for_free_movie_tickets = true
          purchase.save
        end
        break if @free_movie_tickets
      end
      break if @free_movie_tickets
    end
  end
end
