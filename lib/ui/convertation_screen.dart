import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

class ConvertationScreen extends StatefulWidget {
  final Currency currency;

  const ConvertationScreen({super.key, required this.currency});

  @override
  _ConvertationScreenState createState() => _ConvertationScreenState();
}

class _ConvertationScreenState extends State<ConvertationScreen> {
  final TextEditingController _controller = TextEditingController();
  double convertedAmount = 0.0;
  bool isUsdToCurrency = true;

  void _convertCurrency() {
    final amount = double.tryParse(_controller.text);
    if (amount != null) {
      setState(() {
        if (isUsdToCurrency) {
          convertedAmount = amount * widget.currency.currency;
        } else {
          convertedAmount = amount / widget.currency.currency;
        }
      });
    }
  }

  void _toggleConversion() {
    setState(() {
      isUsdToCurrency = !isUsdToCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convert to ${widget.currency.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: isUsdToCurrency
                    ? 'Enter  in USD'
                    : 'Enter  in ${widget.currency.name}',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted: ${convertedAmount.toStringAsFixed(2)} ${isUsdToCurrency ? widget.currency.name : 'USD'}',
            ),
            ElevatedButton(
              onPressed: _toggleConversion,
              child: Text('Switch'),
            ),
          ],
        ),
      ),
    );
  }
}
