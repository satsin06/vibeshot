import '../common/constants/helper.dart';

class SubscriptionModel {
  String price;
  String text;
  String desc;
  String time;

  SubscriptionModel({
    required this.price,
    required this.text,
    required this.desc,
    required this.time,
  });
}

List<SubscriptionModel> subscription = [
  SubscriptionModel(
    price: '\$9.99',
    text: 'Become a Premium',
    desc: AppHelper.loreumIpsum.substring(0, 160),
    time: '1 Month',
  ),
  SubscriptionModel(
    price: '\$9.99',
    text: 'Become a Premium',
    desc: AppHelper.loreumIpsum.substring(0, 160),
    time: '1 Month',
  ),
];
