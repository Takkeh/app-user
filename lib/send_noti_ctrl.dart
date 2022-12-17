import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/utils/shared_prefrences.dart';

const Map<String, dynamic> data = {
  'restaurant_id': 5,
  'route': 'restaurant',
  'title': 'ابو جبارة',
  'cost': 'مجاني',
  'time': '20 - 90 دقيقة',
  'reviewIcon': '4.svg',
  'cover': 'img/restaurants/mcdonald-s.png',
  'logo': 'img/restaurants/16693683296163.jpg',
  'review': 'فاخر',
  'phone': '+96298775785',
};

const Map<String, dynamic> data2 = {
  'restaurant_id': 5,
  'product_id': 18,
  'orderId': 496,
  'route': 'restaurant_order',
  'title': 'ابو جبارة',
  'cost': 'مجاني',
  'time': '20 - 90 دقيقة',
  'reviewIcon': '4.svg',
  'cover': 'img/restaurants/mcdonald-s.png',
  'logo': 'img/restaurants/16693683296163.jpg',
  'review': 'فاخر',
  'phone': '+96298775785',
  'description': 'زاكي كثير',
  'price': 55.5,
  'groups': [
    {
      "id": 33,
      "name": "",
      "type": "required",
      "items": [
        {"id": 65, "name": "gggg", "price": "10.00"},
        {"id": 66, "name": "ggrrr", "price": "20.00"}
      ]
    }
  ],
};

class SendNotificationsCtrl {
  Future<void> send() async {
    try {
      String url = "https://fcm.googleapis.com/fcm/send";
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAR95uOHI:APA91bH_ea918YYCYpnHFaJOHdCyX4ym1COyq2JNF6lAL4K7ph4N1TxVbOm7ynQeqJo-IMFJ7GX3Oql9SytIpdvJQ0HYImZnntRTkZ96LHgFn0m0ObNcdZoTz04oOXrrbDz4O5cTQHNK',
      };
      const Map<String, dynamic> kkkk = {
        "notification": {
          "title": "khaled",
          "body": "awad",
        },
        "data": {
          "id": 5,
          "route": "restaurant",
          "title": "ابو جبارة",
          "cost": "مجاني",
          "time": "20 - 90 دقيقة",
          "reviewIcon": "4.svg",
          "cover": "img/restaurants/mcdonald-s.png",
          "logo": "img/restaurants/16693683296163.jpg",
          "review": "فاخر",
          "phone": "+96298775785",
        }
      };
      var body = jsonEncode(
        {
          'notification': <String, dynamic>{
            'title': "aouefhaefuh",
            'body': "content",
          },
          'priority': 'high',
          'data': data2,
          'to': MySharedPreferences.deviceToken,
          // "registration_ids": tokens,
        },
      );
      log("Response:: SendNotificationResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response = await http.post(uri, headers: headers, body: body);
      log("SendNotificationStatusCode:: ${response.statusCode} SendNotificationBody:: ${response.body}");
      if (response.statusCode == 200) {
        print("Sucess!!");
      } else {
        throw "UpdateProfile Error";
      }
    } catch (e) {
      log("NotificationError:: $e");
    }
  }
}
