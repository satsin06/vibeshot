import 'package:flutter/material.dart';
import 'package:vibeshot/model/model_user.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../model/matches_model.dart';

class MatchesCard extends StatelessWidget {
  const MatchesCard({
    Key? key,
    required this.match,
    required this.press,
  }) : super(key: key);

  final UserData match;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
              // vertical: kDefaultPadding * 0.75,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    match.images.isNotEmpty
                        ? match.images[0]
                        : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${match.name}, ${match.age}',
                          style: AppTextStyles.likeCardName,
                        ),
                        const SizedBox(height: 2),
                        const Opacity(
                          opacity: 0.64,
                          child: Text(
                            '1.4',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
