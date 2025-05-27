import 'package:flutter/material.dart';
import 'package:razorpay_wrapper/razorpay_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Razorpay Wrapper Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RazorpayHomePage(),
    );
  }
}

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
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty || int.tryParse(amountText) == null) {
      _showMessage("⚠️ Please enter a valid amount");
      return;
    }

    final amount = int.parse(amountText) * 100; // convert to paise

    razorpayService.openCheckout(
      apiKey: 'rzp_test_rYrbKpmaflXho9',
      amount: amount,
      name: 'Demo User',
      description: 'Test Payment',
      contact: '9876543210',
      email: 'demo@example.com',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 3),
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
      appBar: AppBar(title: Text('Add Money via Razorpay')),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Enter amount to pay",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Amount in ₹',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text("Make Payment", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
