import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/stripe_payment_service.dart';

class StripePaymentForm extends StatefulWidget {
  final Function({
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cvc,
    required String cardholderName,
    required String email,
  })
  onPaymentSubmit;

  const StripePaymentForm({super.key, required this.onPaymentSubmit});

  @override
  State<StripePaymentForm> createState() => _StripePaymentFormState();
}

class _StripePaymentFormState extends State<StripePaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final _cardholderNameController = TextEditingController();
  final _emailController = TextEditingController();

  String _cardType = 'Unknown';

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _cardholderNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onCardNumberChanged(String value) {
    final formatted = PaymentManager.formatCardNumber(value);
    _cardNumberController.value = _cardNumberController.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    setState(() {
      _cardType = PaymentManager.getCardType(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardNumberField(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(flex: 2, child: _buildExpiryField()),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _buildCVCField()),
            ],
          ),
          const SizedBox(height: 16),
          _buildCardholderNameField(),
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      decoration: InputDecoration(
        labelText: 'Card Number',
        hintText: '1234 5678 9012 3456',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.credit_card),
        suffixIcon: _cardType != 'Unknown'
            ? Container(
                margin: const EdgeInsets.all(8),
                child: _buildCardTypeIcon(),
              )
            : null,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red[600]!),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red[600]!, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
      ],
      onChanged: _onCardNumberChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter card number';
        }
        if (!PaymentManager.isValidCardNumber(value)) {
          return 'Invalid card number';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryField() {
    return TextFormField(
      controller: _expiryController,
      decoration: InputDecoration(
        labelText: 'Expiry Date',
        hintText: 'MM/YY',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _ExpiryDateFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (value.length < 5) {
          return 'Invalid format';
        }
        final parts = value.split('/');
        if (parts.length != 2) {
          return 'Invalid format';
        }
        final month = int.tryParse(parts[0]);
        final year = int.tryParse(parts[1]);
        if (month == null || year == null) {
          return 'Invalid format';
        }
        if (month < 1 || month > 12) {
          return 'Invalid month';
        }
        final currentYear = DateTime.now().year % 100;
        if (year < currentYear) {
          return 'Card expired';
        }
        return null;
      },
    );
  }

  Widget _buildCVCField() {
    return TextFormField(
      controller: _cvcController,
      decoration: InputDecoration(
        labelText: 'CVC',
        hintText: '123',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.lock),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (value.length < 3) {
          return 'Invalid CVC';
        }
        return null;
      },
    );
  }

  Widget _buildCardholderNameField() {
    return TextFormField(
      controller: _cardholderNameController,
      decoration: InputDecoration(
        labelText: 'Cardholder Name',
        hintText: 'John Doe',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.person),
      ),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter cardholder name';
        }
        if (value.length < 2) {
          return 'Name too short';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'john@example.com',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email address';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Invalid email format';
        }
        return null;
      },
    );
  }

  Widget _buildCardTypeIcon() {
    IconData iconData;
    Color iconColor;

    switch (_cardType) {
      case 'Visa':
        iconData = Icons.credit_card;
        iconColor = Colors.blue[800]!;
        break;
      case 'Mastercard':
        iconData = Icons.credit_card;
        iconColor = Colors.red[600]!;
        break;
      case 'American Express':
        iconData = Icons.credit_card;
        iconColor = Colors.green[600]!;
        break;
      default:
        iconData = Icons.credit_card;
        iconColor = Colors.grey[600]!;
    }

    return Icon(iconData, color: iconColor, size: 24);
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final expiryParts = _expiryController.text.split('/');
            final month = int.parse(expiryParts[0]);
            final year = 2000 + int.parse(expiryParts[1]);

            widget.onPaymentSubmit(
              cardNumber: _cardNumberController.text.replaceAll(' ', ''),
              expiryMonth: month,
              expiryYear: year,
              cvc: _cvcController.text,
              cardholderName: _cardholderNameController.text,
              email: _emailController.text,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Pay with Card',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

/// Custom formatter for expiry date input (MM/YY format)
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // If the text is empty, return as is
    if (text.isEmpty) {
      return newValue;
    }

    // Remove all non-digits
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    // Limit to 4 digits
    final limitedDigits = digitsOnly.length > 4
        ? digitsOnly.substring(0, 4)
        : digitsOnly;

    // Format as MM/YY
    String formatted = '';
    if (limitedDigits.isNotEmpty) {
      formatted = limitedDigits.substring(0, 1);
    }
    if (limitedDigits.length >= 2) {
      formatted = '${limitedDigits.substring(0, 2)}/';
    }
    if (limitedDigits.length >= 3) {
      formatted =
          '${limitedDigits.substring(0, 2)}/${limitedDigits.substring(2, 3)}';
    }
    if (limitedDigits.length >= 4) {
      formatted =
          '${limitedDigits.substring(0, 2)}/${limitedDigits.substring(2, 4)}';
    }

    // Calculate cursor position
    int cursorPosition = formatted.length;

    // If user is typing and we just added a slash, move cursor after it
    if (oldValue.text.length < newValue.text.length &&
        formatted.length > oldValue.text.length &&
        formatted.contains('/') &&
        !oldValue.text.contains('/')) {
      cursorPosition = formatted.indexOf('/') + 1;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
