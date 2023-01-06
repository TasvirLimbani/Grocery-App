// import 'package:stripe_payment/stripe_payment.dart';
//
// class PaymentService {
//   final int amount;
//   final String url;
//
//   PaymentService({required this.amount, required this.url});
//
//   static init() {
//     StripePayment.setOptions(
//       StripeOptions(
//           publishableKey:
//               'pk_test_51KOgXnSDVD9JkNVGZZT7tkzhGj1SwXVWg9CbEJm60MfZ8DTh5xHwikpskgHVTNDKoECY13DW3CSVCaqeFILvo2Ji00FccoGkQv',
//           androidPayMode: 'test',
//           merchantId: 'test'),
//     );
//   }
//
//   Future<PaymentMethod?> createPaymentMathod() async {
//     print('the transction amount to be charged is $amount');
//     PaymentMethod paymentMethod =
//         await StripePayment.paymentRequestWithCardForm(
//       CardFormPaymentRequest(),
//     );
//     return paymentMethod;
//   }
//
//   Future<PaymentMethod?> processPaymentMathod(
//       PaymentMethod paymentMethod) async {}
// }
