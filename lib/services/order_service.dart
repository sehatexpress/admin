import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/basket_item_model.dart';
import '../models/order_model.dart';
import '../models/position_model.dart';
import '../providers/auth_provider.dart';

class OrderService {
  final String uid;
  const OrderService(this.uid);

  // get all orders
  Stream<List<OrderModel>> getAllOrders() {
    try {
      return Collections.orders
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get today's orders
  Stream<List<OrderModel>> getTodayOrders(String? city) {
    try {
      var query = Collections.orders.where(
        Fields.date,
        isEqualTo: Object().today,
      );
      if (city != null) {
        query = query.where(
          Fields.restaurantCity,
          isEqualTo: city.translatedCity,
        );
      }
      return query
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get orders by date
  Stream<List<OrderModel>> getOrdersByDate(String date, {String? city}) {
    try {
      var query = Collections.orders.where(Fields.date, isEqualTo: date);
      if (city != null) {
        query =
            query.where(Fields.restaurantCity, isEqualTo: city.translatedCity);
      }
      return query
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get orders by date & restaurant
  Stream<List<OrderModel>> getOrdersByDateAndRestaurant({
    required String date,
    required String rid,
  }) {
    try {
      return Collections.orders
          .where(Fields.date, isEqualTo: date)
          .where(Fields.restaurantId, isEqualTo: rid)
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  //  get all orders by restaurant
  Stream<List<OrderModel>> getOrdersByRestaurant(String id) {
    try {
      return Collections.orders
          .where(Fields.restaurantId, isEqualTo: id)
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  //  get all orders by user
  Future<List<OrderModel>> getOrdersByUser(String id) {
    try {
      return Collections.orders
          .where(Fields.userId, isEqualTo: id)
          .orderBy(Fields.orderedDate, descending: true)
          .get()
          .then((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  //  get all orders by user
  Stream<List<OrderModel>>? getOrdersByDeliveryPerson(String id) {
    try {
      return Collections.orders
          .where(Fields.deliveryPersonId, isEqualTo: id)
          .orderBy(Fields.orderedDate, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // confirm order
  Future<void> confirmOrder({required OrderModel orderModel}) async {
    try {
      await Collections.orders.doc(orderModel.id).update({
        Fields.status: 'confirmed',
        Fields.confirmedDate: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
      // successToastMessage('Please contact restaurant to make prepare meal.');
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // cancell order
  Future<void> cancelOrder({
    required String orderId,
    required String reason,
  }) async {
    try {
      await Collections.orders.doc(orderId).update({
        Fields.status: 'cancelled',
        Fields.cancelledDate: DateTime.now().millisecondsSinceEpoch,
        Fields.cancellationReason: reason,
        Fields.updatedBy: uid,
      });
      // successToastMessage('Order cancelled successfully!');
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get single order
  Stream<OrderModel> getSingleOrder({required String doc}) {
    try {
      return Collections.orders
          .doc(doc)
          .snapshots()
          .map((event) => OrderModel.fromSnapshot(event));
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // transfer order to another delivery partner
  Future<void> transferOrder({
    required OrderModel order,
    required String deliveryPersonId,
    required String deliveryPersonName,
    required String deliveryPersonPhoneNumber,
    required String? deliveryPersonImage,
    required PositionModel deliveryPersonPosition,
  }) async {
    try {
      if (deliveryPersonId != order.deliveryPersonId) {
        await Collections.orders.doc(order.id).update({
          Fields.deliveryPersonId: deliveryPersonId,
          Fields.deliveryPersonName: deliveryPersonName,
          Fields.deliveryPersonPhoneNumber: deliveryPersonPhoneNumber,
          Fields.deliveryPersonImage: deliveryPersonImage,
          Fields.deliveryPersonPosition: deliveryPersonPosition.toDocument(),
          Fields.updatedDate: DateTime.now().millisecondsSinceEpoch,
          Fields.updatedBy: uid,
          Fields.transferredBy: order.deliveryPersonId,
        });
        // successToastMessage('Delivery transferred to $deliveryPersonName succeffully!');
      }
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // modify order
  Future<void> modifyOrder({
    required String orderId,
    required List<BasketItemModel> items,
    required num itemTotal,
    required num grandTotal,
  }) async {
    try {
      await Collections.orders.doc(orderId).update({
        Fields.items: items.map((e) => e.toDocument()).toList(),
        Fields.itemTotal: itemTotal,
        Fields.grandTotal: grandTotal,
        Fields.updatedDate: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
      // successToastMessage('Order updated succeffully!');
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final orderServiceProvider = Provider<OrderService>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid == null) throw Strings.unAuthenticated;
  return OrderService(uid);
});
