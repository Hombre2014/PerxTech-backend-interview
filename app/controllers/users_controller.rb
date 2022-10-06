class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def earning_points(user)
    # user = User.find(params[:id])
    # @purchases_per_user = Purchase.where(user_id: user.id) # .till_date!(Date.today)
    # @purchases_per_user.each do |purchase|
    #   @total_amount_spent += purchase.amount
    #   @unused_amount += purchase.amount
    #   if user.level == 1
    #     if @unused_amount >= 100
    #       user.points += @unused_amount.divmod(100)[0] * 10
    #       @unused_amount = @unused_amount.divmod(100)[1]
    #     end
    #   elsif user.level == 2 && user.country_of_origin != purchase.country_of_purchase
    #       user.points += @total_amount_spent.divmod(100)[0] * 20
    #       @unused_amount = @unused_amount.divmod(100)[1]
    #   end
    # end
    # return user.points
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @total_amount_spent = 0
    @unused_amount = 0
    @user = User.find(params[:id])
    @purchases_per_user = Purchase.where(user_id: @user.id) # .till_date!(Date.today)
    @purchases_per_user.each do |purchase|
      @total_amount_spent += purchase.amount
      @unused_amount += purchase.amount
      if @user.level == 1
        if @unused_amount >= 100
          @user.points += @unused_amount.divmod(100)[0] * 10
          @unused_amount = @unused_amount.divmod(100)[1]
        end
      elsif @user.level == 2 && @user.country_of_origin != purchase.country_of_purchase
        @user.points += @unused_amount.divmod(100)[0] * 20
        @unused_amount = @unused_amount.divmod(100)[1]
      else
        @user.points += @unused_amount.divmod(100)[0] * 10
        @unused_amount = @unused_amount.divmod(100)[1]
      end
    end
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
    params.require(:user).permit(:first_name, :last_name, :birthday, :country_of_origin, :level, :points, :tier)
  end
end
