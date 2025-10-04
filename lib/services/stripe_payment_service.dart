import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'stripe_keys.dart';

abstract class PaymentManager {
  static Future<void> initialize() async {
    Stripe.publishableKey = StripeKeys.publishableKey;
    await Stripe.instance.applySettings();
  }

  static Future<void> makePayment(int price, String currency) async {
    try {
      String clientSecret = await _getClientSecret(
        (price * 100).toString(),
        currency,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Food Delivery App',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {'amount': amount, 'currency': currency},
    );
    return response.data['client_secret'];
  }

  /// Create a payment intent using Stripe API
  static Future<PaymentIntent> createPaymentIntent({
    required double amount,
    required String currency,
    required String orderId,
  }) async {
    try {
      Dio dio = Dio();
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${StripeKeys.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'amount': (amount * 100).round().toString(),
          'currency': currency,
          'metadata[order_id]': orderId,
          'automatic_payment_methods[enabled]': 'true',
        },
      );
      return PaymentIntent.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  /// Confirm payment with card details using Stripe API
  static Future<PaymentIntent> confirmPayment({
    required String paymentIntentId,
    required String clientSecret,
    required PaymentMethodParams params,
  }) async {
    try {
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: params,
      );
      return paymentIntent;
    } catch (e) {
      throw Exception('Payment confirmation failed: $e');
    }
  }

  /// Create payment method from card details using Stripe SDK
  static Future<PaymentMethod> createPaymentMethod({
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cvc,
    String? name,
    String? email,
  }) async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: name, email: email),
          ),
        ),
      );
      return paymentMethod;
    } catch (e) {
      throw Exception('Failed to create payment method: $e');
    }
  }

  /// Validate card number using Luhn algorithm
  static bool isValidCardNumber(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length < 13 || cleaned.length > 19) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Get card type from card number
  static String getCardType(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleaned.startsWith('4')) return 'Visa';
    if (cleaned.startsWith('5') || cleaned.startsWith('2')) return 'Mastercard';
    if (cleaned.startsWith('3')) return 'American Express';
    if (cleaned.startsWith('6')) return 'Discover';

    return 'Unknown';
  }

  /// Format card number with spaces
  static String formatCardNumber(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }

    return buffer.toString();
  }

  /// Format expiry date
  static String formatExpiryDate(String expiry) {
    final cleaned = expiry.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length >= 2) {
      return '${cleaned.substring(0, 2)}/${cleaned.length >= 4 ? cleaned.substring(2, 4) : ''}';
    }
    return cleaned;
  }
}
