require_relative '../helpers/users_helper'
require_relative '../helpers/rewards_helper'

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  include UsersHelper
  include RewardsHelper

  def initial_state
    @points_per_month = 0
    @number_of_big_purchases = 0
    @total_amount_for_movie_tickets = 0
    @free_movie_tickets = false
    @spending_per_quarter = 0
  end

  # GET /users or /users.json
  def index
    @users = User.all.order(id: :asc)
    @reward = Reward.where(user_id: params[:user_id], id: params[:id]).first
    @rewards = Reward.where(user_id: params[:user_id]).all.order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
    initial_state
    @user = User.find(params[:id])
    @users_level_two = User.where(level: 2).all
    rewards(@user)
    @reward = Reward.where(user_id: params[:user_id], id: params[:id]).first
    @rewards = Reward.where(user_id: params[:user_id]).all.order(created_at: :desc)
    check_5_percent_reward
    free_movie_tickets_reward(@users_level_two)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    earning_points(@user)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :country_of_origin, :level, :points, :tier,
                                 :birthday_reward, :total_amount_spent, :unused_amount, :total_amount_spent_foreign,
                                 :unused_amount_foreign)
  end
end
