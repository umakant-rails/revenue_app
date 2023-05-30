import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['amount', 'crsfToken', 'paymentAmount', 'paymentBtn'];

  connect() {
    this.params = {}
  }

  createOptions(orderObj, user, key){
    var order = orderObj.attributes;
    var options = {
      "key": key,
      "amount": order.amount,
      "currency": "INR",
      "name": "Help Desk",
      "description": "Test Transaction",
      // "image": "https://example.com/your_logo",
      "order_id": order.id,
      // "handler": function (response){
      //   console.log(response);
      //   alert(response.razorpay_payment_id);
      //   alert(response.razorpay_order_id);
      //   alert(response.razorpay_signature)
      // },
      "callback_url": "http://localhost:3000/orders/webhook"  ,
      "prefill": {
        "name": user.username,
        "email": user.email,
        "contact": '9111426872'
      },
      // "notes": {
      //   "address": "Razorpay Corporate Office"
      // },
      "theme": {
        "color": "#3399cc"
      }
    };
    var rzp1 = new Razorpay(options);
    rzp1.on('payment.failed', function (response){
      alert(response.error.code, response.error.description);
      // alert(response.error.source);
      // alert(response.error.step);
      // alert(response.error.reason);
      // alert(response.error.metadata.order_id);
      // alert(response.error.metadata.payment_id);
    });
    return rzp1;
  }

  rechargeAccount(event){
    var order_amount = this.amountTarget.value;
    var order_csrf_token = this.crsfTokenTarget.value;

    this.params.authenticity_token = order_csrf_token;
    this.params.order = {amount: order_amount};

    if(order_amount == ''){
      super.showErrorsByLayout("कृपया पहले रिचार्ज की राशि भरे |");
    } else {
      $.ajax({
        url: "/orders/initiate_order",
        method: 'POST',
        dataType: 'json',
        data: this.params
      }).then(res => {
        var rzp1 = this.createOptions(res.order, res.user, res.key);
        rzp1.open();
      });
      event.preventDefault();
    }
  }

  makePayment(){
    var amount = this.paymentAmountTarget.value;
    var requestId = this.paymentAmountTarget.dataset.requestid;

    $.ajax({
      url: "/requests/"+requestId+"/make_payment",
      method: 'POST',
      dataType: 'json',
      data: {payment_amount: amount}
    }).then(res => {
      let my_window = open(location, '_self');
      my_window.close();
      if (window.opener != null && !window.opener.closed) {
        window.opener.location.reload();
      }
    });
  }

  openPaymentWindow(event){
    var requestId =this.paymentBtnTarget.dataset.vl;
    var url = '/requests/'+requestId+'/payment';
    var popup = window.open(url, "Popup", 
      `toolbar=no,scrollbars=no,location=no,statusbar=no,menubar=no,
      resizable=0,width=1000,height=700,left = 490,top = 262`);
    popup.focus();
  }

  closeOpenedWindow(){
    let my_window = open(location, '_self');
    my_window.close();
    if (window.opener != null && !window.opener.closed) {
      window.opener.location.reload();
    }
  }
}
