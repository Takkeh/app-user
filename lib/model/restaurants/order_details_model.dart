class FireOrderDetails {
  final String title;
  final String driverImage;
  final DateTime createdAt;
  final double deliveryFee;
  final double discount;
  final int driverId;
  final String driverName;
  final String driverPhone;
  final String dropPointAddress;
  final String dropPointImage;
  final int dropPointId;
  final String dropPointName;
  final String dropPointPhone;
  final double finalPrice;
  final String userAddress;

  FireOrderDetails({
    required this.title,
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
    required this.userAddress,
  });

  FireOrderDetails.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          createdAt: json['created_at']! as DateTime,
          deliveryFee: double.parse(json['delivery_fee'].toString()),
          discount: double.parse(json['discount'].toString()),
          driverId: json['driver_id'] as int,
          driverImage: json['driver_image'] as String,
          driverName: json['driver_name'] as String,
          driverPhone: json['driver_phone'] as String,
          dropPointAddress: json['drop_point_address'] as String,
          dropPointId: json['drop_point_id'] as int,
          dropPointImage: json['drop_point_image'] as String,
          dropPointName: json['drop_point_name'] as String,
          dropPointPhone: json['drop_point_phone'] as String,
          finalPrice: double.parse(json['final_price'].toString()),
          userAddress: json['user_address'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'genre': driverImage,
      'created_at': createdAt,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'driver_id': driverId,
      'driver_name': driverName,
      'driver_phone': driverPhone,
      'drop_point_address': dropPointAddress,
      'drop_point_id': dropPointId,
      'drop_point_image': dropPointImage,
      'drop_point_name': dropPointName,
      'drop_point_phone': dropPointPhone,
      'final_price': finalPrice,
      'user_address': userAddress,
    };
  }
}
