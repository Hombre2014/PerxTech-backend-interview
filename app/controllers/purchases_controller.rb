class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show edit update destroy]

  # GET /purchases or /purchases.json
  def index
    @purchases_per_user = Purchase.where(user_id: params[:user_id]).order(date: :asc)
  end

  def all
    @purchases = Purchase.all.sort_by(&:date)
  end

  # GET /purchases/1 or /purchases/1.json
  def show
    @user = User.find(params[:user_id])
    @purchase = Purchase.where(user_id: params[:user_id], id: params[:id]).first
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit; end

  # POST /purchases or /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html do
          redirect_to "/users/#{params[:user_id]}/purchases/#{params[:id]}",
                      notice: 'Purchase was successfully created.'
        end
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to user_purchase_path, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def purchase_params
    params.require(:purchase).permit(:date, :country_of_purchase, :amount, :user_id, :counted, :processed_for_points)
  end
end
