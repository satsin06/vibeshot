import 'package:flutter_tinder_swipe/flutter_tinder_swipe.dart';
import 'package:get/get.dart';

class CardSwipeController {
  CardController cardController = CardController();

  void swipeLeft() => cardController.swipeLeft();

  void swipeRight() => cardController.swipeRight();
}
