import 'package:flutter/material.dart';
import 'package:razorpay_wrapper/razorpay_wrapper.dart';

class RazorpayHomePage extends StatefulWidget {
  @override
  _RazorpayHomePageState createState() => _RazorpayHomePageState();
}

class _RazorpayHomePageState extends State<RazorpayHomePage> {
  late RazorpayService razorpayService;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpayService = RazorpayService(
      onSuccess: (res) => _showMessage("✅ Payment Success: ${res.paymentId}"),
      onError: (res) => _showMessage("❌ Payment Failed: ${res.message}"),
      onExternalWallet: (res) => _showMessage("💼 External Wallet: ${res.walletName}"),
    );
  }

  void _startPayment() {
    final text = _amountController.text.trim();
    if (text.isEmpty || int.tryParse(text) == null) {
      _showMessage("⚠️ Enter a valid amount");
      return;
    }

    final amount = int.parse(text) * 100; // to paise

    razorpayService.openCheckout(
      apiKey: 'rzp_test_rYrbKpmaflXho9', // replace with your actual test key
      amount: amount,
      name: 'Demo User',
      description: 'Test Transaction',
      contact: '9999999999',
      email: 'demo@example.com',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razorpay Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter amount to pay:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount in ₹",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _startPayment,
                child: Text("Pay Now", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
