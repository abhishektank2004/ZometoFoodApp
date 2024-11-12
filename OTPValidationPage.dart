import 'package:flutter/material.dart';

class OTPValidationPage extends StatefulWidget {
  final String email;
  final String otp;

  OTPValidationPage({required this.email, required this.otp});

  @override
  _OTPValidationPageState createState() => _OTPValidationPageState();
}

class _OTPValidationPageState extends State<OTPValidationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  void _validateOTP() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_otpController.text == widget.otp) {
        // OTP is valid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP validated successfully. You can now reset your password.'),
            duration: Duration(seconds: 3),
          ),
        );

        // Navigate back or proceed to the next step
        Navigator.of(context).pop();
      } else {
        // OTP is invalid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate OTP'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter the 6-digit OTP sent to ${widget.email}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
                    return 'Please enter a valid 6-digit OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: _validateOTP,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Validate OTP'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
