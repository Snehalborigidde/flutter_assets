import 'package:flutter_test/flutter_test.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_wrapper/razorpay_wrapper.dart';

void main() {
  group('RazorpayService', () {
    late RazorpayService razorpayService;

    final onSuccess = (PaymentSuccessResponse response) {
      print('Payment successful: ${response.paymentId}');
    };

    final onError = (PaymentFailureResponse response) {
      print('Payment failed: ${response.code}');
    };

    final onExternalWallet = (ExternalWalletResponse response) {
      print('External wallet selected: ${response.walletName}');
    };

    setUp(() {
      razorpayService = RazorpayService(
        onSuccess: onSuccess,
        onError: onError,
        onExternalWallet: onExternalWallet,
      );
    });

    test('should initialize without throwing', () {
      expect(razorpayService, isNotNull);
    });

    test('should open checkout without throwing error', () {
      expect(
            () => razorpayService.openCheckout(
          apiKey: 'rzp_test_1234567890',
          amount: 1000, // ₹10 in paise
          name: 'Test User',
          description: 'Test Purchase',
          contact: '9876543210',
          email: 'test@example.com',
        ),
        returnsNormally,
      );
    });

    test('should dispose without throwing', () {
      expect(() => razorpayService.dispose(), returnsNormally);
    });
  });
}
