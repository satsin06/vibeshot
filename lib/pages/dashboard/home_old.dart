// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:tcard/tcard.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:vibeshot/pages/dashboard/widgets/home_detailed_page_collapsed.dart';
// import '../../common/constants/app_constants.dart';
// import '../../common/theme/app_text_styles.dart';
// import '../../common/utility/size_config.dart';
// import '../../model/user_model.dart';
// import 'helper/home_helper.dart';

// import 'widgets/my_icon_row.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TCardController _cardController = TCardController();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     double width = screenSize.width;
//     double height = screenSize.height;
//     List<Widget> cards = List.generate(
//       HomeHelper.users.length,
//       (int index) {
//         return HomeDetailPage(
//           user: HomeHelper.users[index],
//         );
//       },
//     );

//     return TCard(
//       size: Size(width, height),
//       lockYAxis: true,
//       controller: _cardController,
//       cards: cards,
//     );
//   }
// }

// class UserprofileCard extends StatelessWidget {
//   const UserprofileCard({
//     Key? key,
//     required this.singleUser,
//   }) : super(key: key);

//   final UserModel singleUser;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: SizeConfig.screenHeight - 60,
//       width: SizeConfig.screenWidth - 30,
//       child: Stack(
//         children: [
//           const UserBackgroungImage(),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               height: SizeConfig.screenHeight * 0.34,
//               width: SizeConfig.screenWidth - 30,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: kDefaultPadding,
//                 vertical: kDefaultPadding,
//               ),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(31),
//                   topRight: Radius.circular(31),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 4,
//                       width: 90,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(36),
//                       ),
//                     ),
//                   ),
//                   const HeightBox(20),
//                   Text(
//                     '${singleUser.name}, ${singleUser.age}',
//                     style: AppTextStyles.profileName,
//                   ),
//                   Row(
//                     children: [
//                       const Icon(
//                         CupertinoIcons.location,
//                       ),
//                       const WidthBox(8),
//                       Text(
//                         singleUser.distance,
//                         style: AppTextStyles.profileAge,
//                       ),
//                     ],
//                   ),
//                   const HeightBox(10),
//                   Text(
//                     singleUser.shortDescription,
//                     style: AppTextStyles.profileShortDes,
//                   ),
//                   const HeightBox(12),
//                   const MyIconRow(),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class UserBackgroungImage extends StatelessWidget {
//   const UserBackgroungImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: SizeConfig.screenHeight - 40,
//       width: SizeConfig.screenWidth - 40,
//       child: CachedNetworkImage(
//         imageUrl: HomeHelper.users[0].featuredImage[3],
//         imageBuilder: (context, imageProvider) => Container(
//           height: SizeConfig.screenHeight,
//           margin: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 10,
//           ),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: imageProvider,
//               fit: BoxFit.cover,
//             ),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(31),
//               topRight: Radius.circular(31),
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black45,
//                 blurRadius: 6,
//                 offset: Offset(0, 3),
//               )
//             ],
//           ),
//         ),
//         placeholder: (_, __) => VxShimmer(
//           child: Container(
//             height: SizeConfig.screenHeight - 40,
//             width: SizeConfig.screenWidth - 40,
//             margin: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 10,
//             ),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(31),
//                 topRight: Radius.circular(31),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black45,
//                   blurRadius: 6,
//                   offset: Offset(0, 3),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
