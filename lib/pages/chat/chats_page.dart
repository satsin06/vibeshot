import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/controller/matches_controller.dart';
import 'package:vibeshot/pages/dashboard/widgets/matches_card.dart';
import '../../common/theme/colors.dart';

import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../dashboard/helper/home_helper.dart';
import 'components/body.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final MatchesController _matchesController = Get.put(MatchesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context),
        body: const Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return 
    AppBar(
      automaticallyImplyLeading: false,
      title: Text('',),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_vert_outlined,
            size: 28,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
