class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:webhook]
 
  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def initiate_a_order
    amount = params[:order][:amount]
    razorpay_order = Order.place_a_order(amount.to_i*100)

    respond_to do |format|
      if razorpay_order.amount.present?
        format.json { render json: {order: razorpay_order, user: current_user, key: ENV['RAZORPAY_ID']} }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @order = current_user.orders.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def webhook
    order_detail = Order.get_a_order(params[:razorpay_payment_id])

    if order_detail.captured
      amt = order_detail.amount/100
      @order = current_user.orders.create(
        order_id: params[:razorpay_order_id],
        payment_id: params[:razorpay_payment_id], 
        signature: params[:razorpay_signature], 
        amount: amt,
        status: order_detail.captured
      )

      last_transaction = current_user.payment_transactions.last
      new_amt = last_transaction.blank? ? amt : last_transaction.amount.to_i + amt  
      current_user.payment_transactions.create(
        transactionable:@order, credit: amt, amount: new_amt, app_number: @order.order_id
      )
    end

    respond_to do |format|
      format.html { redirect_to new_order_url, notice: "Your account successfully reacharge with #{amt}." }
      format.json { head :no_content }
    end
  end

  def transactions
    @transactions = current_user.payment_transactions.order("created_at DESC")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order).permit(:amount, :user_id, :payment_id, :status)
    end
end
