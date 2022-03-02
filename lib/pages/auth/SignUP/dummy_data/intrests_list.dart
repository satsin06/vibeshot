import 'package:get/get.dart';
import 'package:vibeshot/model/intrest_model.dart';

const List<String> possibleIntrests = [
  'Board Game',
  'Athlete',
  'Walking',
  'Festivals',
  'Vlogging',
  'Sushi',
  'Football',
  'Tea',
  'Fashion',
  'Films',
  'Reading',
  'Karaoke',
  'Brunch',
  'Baking',
  'Grab a drink',
  'Craft beer',
  'Museum',
  'Photography',
  'Trainers',
  'Cricket',
  'Vegitarian',
  '90\'s kid',
  'K-Pop',
  'Coffee',
  'Potterhead',
  'Hiking',
  'Disney',
  'Travel',
  'Environmentalism',
  'Blogging',
  'Instagram',
  'Picnicking',
  'Spirituality',
  'Dog Lover',
  'Plant-based',
  'Swimming',
  'Dog lover',
  'Plant-based',
  'Swimming',
  'Trivia',
  'VR Room',
  'Sports',
];

class IntrestListClass extends GetxController {
  static var intrestList = possibleIntrests
      .map(
        (String intrestString) => Intrest(
          name: intrestString,
        ),
      )
      .toList().obs;

  static void resetIntrest() {
    intrestList = possibleIntrests
        .map(
          (String intrestString) => Intrest(
            name: intrestString,
          ),
        )
        .toList().obs;
  }
}
