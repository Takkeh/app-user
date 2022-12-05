import 'package:cloud_firestore/cloud_firestore.dart';

class FireOrderDetails {
  final Timestamp createdAt;
  final int driverId;
  final int dropPointId;
  final int orderId;
  final int pickUpPointId;
  final String driverImage;
  final String driverName;
  final String driverPhone;
  final String dropPointAddress;
  final String dropPointImage;
  final String dropPointName;
  final String dropPointPhone;
  final String note;
  final String paymentMethod;
  final String pickUpPointName;
  final String pickUpPointAddress;
  final String pickUpPointImage;
  final String pickUpPointPhone;
  final String status;
  final String type;
  final String userName;
  final double finalPrice;
  final double deliveryFee;
  final double discount;
  final double tax;
  final double totalPrice;
  final List<FireOrderDetailsList> orderDetailsList;
  final DropPosition dropPointPosition;
  final PickUpPosition pickUpPointPosition;

  FireOrderDetails({
    required this.driverImage,
    required this.createdAt,
    required this.deliveryFee,
    required this.discount,
    required this.driverId,
    required this.driverName,
    required this.driverPhone,
    required this.dropPointAddress,
    required this.dropPointId,
    required this.dropPointImage,
    required this.dropPointName,
    required this.dropPointPhone,
    required this.finalPrice,
    required this.note,
    required this.orderDetailsList,
    required this.orderId,
    required this.paymentMethod,
    required this.pickUpPointAddress,
    required this.pickUpPointId,
    required this.pickUpPointImage,
    required this.pickUpPointName,
    required this.pickUpPointPhone,
    required this.status,
    required this.tax,
    required this.userName,
    required this.totalPrice,
    required this.type,
    required this.dropPointPosition,
    required this.pickUpPointPosition,
  });

  FireOrderDetails.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['created_at'] as Timestamp,
          driverId: json['driver_id'] as int,
          orderId: json['order_id'] as int,
          dropPointId: json['drop_point_id'] as int,
          pickUpPointId: json['pickup_point_id'] as int,
          driverImage: json['driver_image'] as String,
          driverName: json['driver_name'] as String,
          driverPhone: json['driver_phone'] as String,
          dropPointAddress: json['drop_point_address'] as String,
          dropPointImage: json['drop_point_image'] as String,
          dropPointName: json['drop_point_name'] as String,
          dropPointPhone: json['drop_point_phone'] as String,
          note: json['note'] as String,
          paymentMethod: json['payment_method'] as String,
          pickUpPointAddress: json['pickup_point_address'] as String,
          pickUpPointImage: json['pickup_point_image'] as String,
          pickUpPointName: json['pickup_point_name'] as String,
          pickUpPointPhone: json['pickup_point_phone'] as String,
          status: json['status'] as String,
          type: json['type'] as String,
          userName: json['user_name'] as String,
          tax: double.parse(json['tax'].toString()),
          deliveryFee: double.parse(json['delivery_fee'].toString()),
          discount: double.parse(json['discount'].toString()),
          totalPrice: double.parse(json['total_price'].toString()),
          finalPrice: double.parse(json['final_price'].toString()),
          orderDetailsList: List<FireOrderDetailsList>.from((json['order_details'] as List<dynamic>).map((x) => FireOrderDetailsList.fromJson(x))),
          dropPointPosition: DropPosition.fromJson(json["drop_point_position"] as Map<String, dynamic>),
          pickUpPointPosition: PickUpPosition.fromJson(json["pickup_point_position"] as Map<String, dynamic>),
        );

  Map<String, Object?> toJson() {
    return {
      'created_at': createdAt,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'driver_id': driverId,
      'driver_image': driverImage,
      'driver_name': driverName,
      'driver_phone': driverPhone,
      'drop_point_address': dropPointAddress,
      'drop_point_id': dropPointId,
      'drop_point_image': dropPointImage,
      'drop_point_name': dropPointName,
      'drop_point_phone': dropPointPhone,
      'final_price': finalPrice,
      'note': note,
      'user_name': userName,
      'order_id': orderId,
      'payment_method': paymentMethod,
      'pickup_point_address': pickUpPointAddress,
      'pickup_point_id': pickUpPointId,
      'pickup_point_image': pickUpPointImage,
      'pickup_point_name': pickUpPointName,
      'pickup_point_phone': pickUpPointPhone,
      'status': status,
      'type': type,
      'tax': tax,
      'total_price': totalPrice,
      'order_details': orderDetailsList,
      'drop_point_position': dropPointPosition,
      'pickup_point_position': pickUpPointPosition,
    };
  }
}

class FireOrderDetailsList {
  final int id;
  final String name;
  final double price;
  final int quantity;

  FireOrderDetailsList({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  FireOrderDetailsList.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          name: json['name'] as String,
          price: double.parse(json['price'].toString()),
          quantity: json['quantity'] as int,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

class PickUpPosition {
  final String geohash;
  final GeoPoint geopoint;

  PickUpPosition({
    required this.geohash,
    required this.geopoint,
  });

  PickUpPosition.fromJson(Map<String, Object?> json)
      : this(
          geohash: json['geohash']! as String,
          geopoint: json['geopoint'] as GeoPoint,
        );

  Map<String, Object?> toJson() {
    return {
      'geohash': geohash,
      'geopoint': geopoint,
    };
  }
}

class DropPosition {
  final String geohash;
  final GeoPoint geopoint;

  DropPosition({
    required this.geohash,
    required this.geopoint,
  });

  DropPosition.fromJson(Map<String, Object?> json)
      : this(
          geohash: json['geohash']! as String,
          geopoint: json['geopoint'] as GeoPoint,
        );

  Map<String, Object?> toJson() {
    return {
      'geohash': geohash,
      'geopoint': geopoint,
    };
  }
}
