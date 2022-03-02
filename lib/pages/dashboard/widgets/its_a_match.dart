import 'package:flutter/material.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:vibeshot/common/widgets/app_button.dart';
import 'package:vibeshot/model/model_user.dart';

class ItsAMatchPopUp extends StatelessWidget {
  const ItsAMatchPopUp({
    Key? key,
    required this.data,
  }) : super(key: key);

  final UserData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(150), horizontal: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffE5DEFA), Color(0xffffffff)],
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Its a match',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      data.images[0],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
              Text(
                data.aboutMe,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18),
              ),
              AppButton(buttonText: 'Send A Message', onPressed: () {}),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: getProportionateScreenHeight(140),
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
    );
  }
}
