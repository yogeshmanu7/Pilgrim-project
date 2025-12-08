<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<div class="text-center">
  <button id="payBtn" class="btn btn-success btn-lg px-5">Pay Now</button>
</div>

<script>
  var options = {
    "key": "${razorpayKey}",
    "amount": "${booking.amountPaid * 100}",
    "currency": "INR",
    "name": "GlobalPiligrim Travel",
    "description": "Booking Payment",
    "order_id": "${orderId}",
    "handler": function (response){
        fetch("${pageContext.request.contextPath}/pilgrim/travel/booking/user/confirm", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                razorpay_payment_id: response.razorpay_payment_id,
                email: "${email}"
            })
        }).then(res => {
            if (res.ok) {
                window.location.href="${pageContext.request.contextPath}/pilgrim/travel/booking/user/success";
            } else {
                alert("Payment confirmation failed!");
            }
        });
    },
    "prefill": {
        "name": "${userName}",
        "email": "${email}",
        "contact": "${mobile}"
    },
    "theme": { "color": "#3399cc" }
  };
  document.getElementById('payBtn').onclick = function(e){
    var rzp1 = new Razorpay(options);
    rzp1.open();
    e.preventDefault();
  }
</script>

