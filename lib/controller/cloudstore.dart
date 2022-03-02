import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';

class CloudStorage {
  static CloudStorage get instanace => CloudStorage();
  // About Firebase Database

  Future<void> updateUserToken(userID, token) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'FCMToken':token,
    });
  }

  Future<List<DocumentSnapshot>> takeUserInformationFromFBDB() async{
        String? uid = UserSimplePreferences.getPhoneNum();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot result =
    await FirebaseFirestore.instance.
      collection('users').doc(uid).collection('token').
      where('FCMToken', isEqualTo: prefs.get('tokenId') ?? 'None').
      get();
    return result.docs;
  }

  Future updateUserChatListField(String documentID,String lastMessage,chatID,myID,selectedUserID) async{
  }

  Future sendMessageToUser(chatID,selectedUserID,content,messageType) async {
    String? uid = UserSimplePreferences.getPhoneNum();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(chatID)
        .doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
      //'idFrom': myID,
      'idTo': selectedUserID,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'content': content,
      'type':messageType,
      'isread':false,
    });
  }
}