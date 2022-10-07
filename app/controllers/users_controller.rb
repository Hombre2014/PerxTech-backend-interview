require_relative '../helpers/users_helper'

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  include UsersHelper

  def initial_state
    @total_amount_spent = 0
    @unused_amount = 0
    @total_amount_spent_foreign = 0
    @unused_amount_foreign = 0
    @points_per_month = 0
  end

  # GET /users or /users.json
  def index
    @users = User.all
    @reward = Reward.where(user_id: params[:user_id], id: params[:id]).first
    @rewards = Reward.where(user_id: params[:user_id]).all.order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
    initial_state
    rewards(@user)
    @user = User.find(params[:id])
    @reward = Reward.where(user_id: params[:user_id], id: params[:id]).first
    @rewards = Reward.where(user_id: params[:user_id]).all.order(created_at: :desc)
    earning_points(@user)
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
    params.require(:user).permit(:first_name, :last_name, :birthday, :country_of_origin, :level, :points, :tier, :birthday_reward)
  end
end
