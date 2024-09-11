import 'package:flutter/material.dart';

class AppointmentPaymentScreen extends StatefulWidget {
  @override
  _AppointmentPaymentScreenState createState() => _AppointmentPaymentScreenState();
}

class _AppointmentPaymentScreenState extends State<AppointmentPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedPaymentMethod = 'Cash';
  TextEditingController _amountController = TextEditingController();
  TextEditingController _transactionIdController = TextEditingController();

  void _handlePayment() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle payment processing here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text('Payment of ${_amountController.text} has been processed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Payment'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  PaymentOptionCard(
                    icon: Icons.money_off,
                    title: 'Cash',
                    subtitle: 'Pay with cash at the clinic',
                    color: Colors.amber[100]!,
                    isSelected: _selectedPaymentMethod == 'Cash',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Cash';
                      });
                    },
                  ),
                  PaymentOptionCard(
                    icon: Icons.payment,
                    title: 'Online Payment',
                    subtitle: 'Pay through online banking',
                    color: Colors.blue[100]!,
                    isSelected: _selectedPaymentMethod == 'Online Payment',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Online Payment';
                      });
                    },
                  ),
                  PaymentOptionCard(
                    icon: Icons.mobile_friendly,
                    title: 'UPI Payment',
                    subtitle: 'Pay using UPI apps like PhonePe, Google Pay, etc.',
                    color: Colors.pink[100]!,
                    isSelected: _selectedPaymentMethod == 'UPI Payment',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'UPI Payment';
                      });
                    },
                  ),
                  PaymentOptionCard(
                    icon: Icons.credit_card,
                    title: 'Credit/Debit Card',
                    subtitle: 'Pay using your credit or debit card',
                    color: Colors.green[100]!,
                    isSelected: _selectedPaymentMethod == 'Credit/Debit Card',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Credit/Debit Card';
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _transactionIdController,
                    decoration: InputDecoration(
                      labelText: 'Transaction ID',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a transaction ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handlePayment,
                    child: Text('Confirm Payment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  PaymentOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: isSelected ? 8 : 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [isSelected ? color.withOpacity(0.8) : color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              subtitle,
              style:   TextStyle(
                color: Colors.white70,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
