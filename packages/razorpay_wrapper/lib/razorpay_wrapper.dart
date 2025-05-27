library razorpay_wrapper;

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

typedef PaymentSuccessCallback = void Function(PaymentSuccessResponse);
typedef PaymentErrorCallback = void Function(PaymentFailureResponse);
typedef ExternalWalletCallback = void Function(ExternalWalletResponse);

class RazorpayService {
  final Razorpay _razorpay = Razorpay();

  RazorpayService({
    required PaymentSuccessCallback onSuccess,
    required PaymentErrorCallback onError,
    required ExternalWalletCallback onExternalWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout({
    required String apiKey,
    required int amount,
    required String name,
    required String description,
    required String contact,
    required String email,
  }) {
    final options = {
      'key': apiKey,
      'amount': amount, // In paise
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}
