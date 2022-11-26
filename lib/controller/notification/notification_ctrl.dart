import 'package:get/get.dart';
import 'package:takkeh/model/notification/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class NotificationCtrl extends GetxController {
  static NotificationCtrl get find => Get.find();
  List<String> filter = ["Today","Yesterday","Older Notifications"];
  List<List<NotificationModel>> notifications = [];
  List<NotificationModel> today = [];
  List<NotificationModel> yesterday = [];
  List<NotificationModel> older = [];

  final CollectionReference<NotificationModel> collectionRef =
      FirebaseFirestore.instance.collection('notification').withConverter(
            fromFirestore: (snapshot, _) =>
                NotificationModel.fromJson(snapshot.data()!),
            toFirestore: (notification, _) => notification.toJson(),
          );

  Future<List<List<NotificationModel>>?> getData() async {
    try {
      await collectionRef
          .where('user_id', isEqualTo: MySharedPreferences.userId)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          if (result.data().createdAt.toDate().day == DateTime.now().day) {
            today.add(result.data());
          } else if (result.data().createdAt.toDate().day ==
              DateTime.now().subtract(const Duration(days: 1)).day) {
            yesterday.add(result.data());
          }
          else{
            older.add(result.data());
          }

        }
      });
      notifications.add(today);
      notifications.add(yesterday);
      notifications.add(older);
      return notifications;
    } catch (e) {
      print('error');
      return null;
    }
  }
}
