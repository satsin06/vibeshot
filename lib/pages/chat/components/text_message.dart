import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/theme/colors.dart';
import '../../../model/chat_message.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return (!message!.isSender)
        ? MessageRecived(message: message)
        : MessageSent(message: message);
  }
}

class MessageSent extends StatelessWidget {
  const MessageSent({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: AppColors.primaryColor,
      color: AppColors.primaryColor,
      type: MaterialType.canvas,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      elevation: 3,
      child: Container(
        width: SizeConfig.screenWidth * 0.7,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding - 5,
        ),
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message!.text,
              style: AppTextStyles.chatSent,
            ),
            const HeightBox(6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message!.time,
                style: AppTextStyles.chatSentTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageRecived extends StatelessWidget {
  const MessageRecived({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: AppColors.primaryColor,
      color: Colors.white,
      type: MaterialType.canvas,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      elevation: 3,
      child: Container(
        width: SizeConfig.screenWidth * 0.7,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding - 5,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message!.text,
              style: AppTextStyles.chatRecived,
            ),
            const HeightBox(6),
            Text(
              message!.time,
              style: AppTextStyles.chatTime,
            ),
          ],
        ),
      ),
    );
  }
}
