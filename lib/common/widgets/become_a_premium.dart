import 'package:flutter/material.dart';
import 'package:vibeshot/pages/profile/widgets/subscription_crousal.dart';

class BecomeAPremiumPopUp extends StatelessWidget {
  const BecomeAPremiumPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 440,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(240, 237, 249, 0.98),
                      Colors.white,
                    ],
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SubscriptionCrousal(),
              ),
            ),
            Positioned(
              right: 20,
              top: 0,
              child: SizedBox(
                height: 40,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
