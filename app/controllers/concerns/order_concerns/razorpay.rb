module OrderConcerns::Razorpay
  extend ActiveSupport::Concern
  included do
    class << self
      def create_order(amount)
        order = Razorpay::Order.create(
          amount: amount, 
          currency: 'INR', 
          #receipt: cart.uuid, 
          payment_capture: 1
        )
        order
      end

      def fetch_payment(raz_payment_id)
        Razorpay::Payment.fetch(raz_payment_id)
      end
    end
  end
end