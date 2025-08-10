import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const loading = 'Loading...';
  static const cancle = 'Cancel';
  static const logout = 'Logout';
  static const delete = 'Delete';
  static const enable = 'Enable';
  static const dismiss = 'Dismiss';
  static const yes = 'Yes';
  static const no = 'No';
  static const error = 'Something went wrong. Please try again!';
  static const genericAlertDescription = 'Are you sure, you want to ';
  static const removedfromFavourite = 'Restaurant removed from favourite.';
  static const addedTofavourite = 'Restaurant added to favourite.';
  static const unAuthenticated =
      'You are not authenticated. Please login to continue.';
  static const loginBeforeProceeding =
      'Authentication - Please login before preceeding!';
  static const loginToApplyVoucher = 'Please login to apply vouchers';
  static const duplicateMobile =
      'The mobile number you entered is already associated with another account. Please try a different number.';
  static const userNotFound =
      'No account found with the provided email, phone number, or username. Please check your details or sign up for a new account.';
  static const restaurantClosed =
      'Restaurant Closed - Restaurant has been closed. Please wait for the restaurant to open.';
  static const emptyBasket =
      'Empty Basket - Please add some items in the basket to place order!';
  static const selectDeliveryAddres =
      'Select Address - Please choose a delivery address!';
  static const changeDeliveryAddres =
      'Change Delivery Address - Seems like your delivery address is more than 5km. Please choose a delivery address with in 5km of radius or order from a restaurant nearby.';
  static const genericOrderError =
      'Error - Something went while placing your order. Please try again after some time.';
  static const updateAvailableTitle =
      '🚀 Enhance Your Experience with the Latest Update! 🚀';
  static const updateAvailableMessage =
      'We\'ve introduced exciting new features, optimized performance, and implemented key improvements to elevate your app experience.';
  static const updateAvailableAction =
      '🎉 Hit the "Update Now" to enjoy the latest advancements! 🎉';
  static const passwordUpdated =
      'You have successfully changed your password. You can now login with your new password!';
  static const passwordResetLink =
      'A password reset link has been sent to your registered email. Please check your inbox and follow the link to update your password.';
  const Strings._();
}

@immutable
class Collections {
  static var cities = FirebaseFirestore.instance.collection('cities');
  static var cityLocation = FirebaseFirestore.instance.collection(
    'cityLocations',
  );
  static var creators = FirebaseFirestore.instance.collection('creators');
  static var banners = FirebaseFirestore.instance.collection('banners');
  static var categories = FirebaseFirestore.instance.collection('categories');
  static var menus = FirebaseFirestore.instance.collection('menus');
  static var users = FirebaseFirestore.instance.collection('users');
  static var address = FirebaseFirestore.instance.collection('address');
  static var settings = FirebaseFirestore.instance.collection('settings');
  static var orders = FirebaseFirestore.instance.collection('orders');
  static var restaurants = FirebaseFirestore.instance.collection('restaurants');
  static var products = FirebaseFirestore.instance.collection('products');
  static var vouchers = FirebaseFirestore.instance.collection('vouchers');
  static var queries = FirebaseFirestore.instance.collection('queries');
  static var comments = FirebaseFirestore.instance.collection('comments');
  static var deliveryPartners = FirebaseFirestore.instance.collection(
    'deliveryPartners',
  );
  const Collections._();
}

@immutable
class Fields {
  static const id = 'id';
  static const uid = 'uid';
  static const createdAt = 'createdAt';
  static const deviceToken = 'deviceToken';
  static const email = 'email';
  static const freeDelivery = 'freeDelivery';
  static const gender = 'gender';
  static const mobile = 'mobile';
  static const password = 'password';
  static const action = 'action';
  static const name = 'name';
  static const points = 'points';
  static const status = 'status';
  static const updatedAt = 'updatedAt';
  static const addressType = 'addressType';
  static const street = 'street';
  static const position = 'position';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const geohash = 'geohash';
  static const geopoint = 'geopoint';
  static const displayName = 'displayName';
  static const city = 'city';
  static const cityId = 'cityId';
  static const locationId = 'locationId';
  static const cities = 'cities';
  static const image = 'image';
  static const category = 'category';
  static const categoryId = 'categoryId';
  static const commission = 'commission';
  static const commissionType = 'commissionType';
  static const price = 'price';
  static const sellingPrice = 'sellingPrice';
  static const rating = 'rating';
  static const quantity = 'quantity';
  static const description = 'description';
  static const type = 'type';
  static const restaurantId = 'restaurantId';
  static const restaurantName = 'restaurantName';
  static const restaurantImage = 'restaurantImage';
  static const restaurantCity = 'restaurantCity';
  static const restaurantStreet = 'restaurantStreet';
  static const restaurantNumber = 'restaurantNumber';
  static const restaurantPosition = 'restaurantPosition';
  static const userId = 'userId';
  static const userName = 'userName';
  static const userEmail = 'userEmail';
  static const userPhoneNumber = 'userPhoneNumber';
  static const deliveryAddressPersonName = 'deliveryAddressPersonName';
  static const deliveryAddressPersonPhoneNumber =
      'deliveryAddressPersonPhoneNumber';
  static const deliveryAddressStreet = 'deliveryAddressStreet';
  static const deliveryAddressPosition = 'deliveryAddressPosition';
  static const items = 'items';
  static const itemTotal = 'itemTotal';
  static const deliveryCharge = 'deliveryCharge';
  static const discount = 'discount';
  static const discountVoucherId = 'discountVoucherId';
  static const discountVoucherCode = 'discountVoucherCode';
  static const tip = 'tip';
  static const grandTotal = 'grandTotal';
  static const deliveryPersonId = 'deliveryPersonId';
  static const deliveryPersonName = 'deliveryPersonName';
  static const deliveryPersonPhoneNumber = 'deliveryPersonPhoneNumber';
  static const deliveryPersonImage = 'deliveryPersonImage';
  static const deliveryPersonPosition = 'deliveryPersonPosition';
  static const progress = 'progress';
  static const orderedDate = 'orderedDate';
  static const acceptedDate = 'acceptedDate';
  static const confirmedDate = 'confirmedDate';
  static const pickedDate = 'pickedDate';
  static const deliveredDate = 'deliveredDate';
  static const cancelledDate = 'cancelledDate';
  static const cancellationReason = 'cancellationReason';
  static const updatedDate = 'updatedDate';
  static const restaurantBalance = 'restaurantBalance';
  static const deliveryPersonBalance = 'deliveryPersonBalance';
  static const date = 'date';
  static const platform = 'platform';
  static const defaultConfirmed = 'defaultConfirmed';
  static const isNew = 'isNew';
  static const featured = 'featured';
  static const newProduct = 'newProduct';
  static const recommended = 'recommended';
  static const averageRating = 'averageRating';
  static const totalRating = 'totalRating';
  static const totalUsers = 'totalUsers';
  static const likes = 'likes';
  static const sold = 'sold';
  static const bestSeller = 'bestSeller';
  static const orderOTP = 'orderOTP';
  static const value = 'value';
  static const code = 'code';
  static const minimumOrder = 'minimumOrder';
  static const beginDate = 'beginDate';
  static const expiryDate = 'expiryDate';
  static const upto = 'upto';
  static const users = 'users';
  static const conditions = 'conditions';
  static const deliveryTime = 'deliveryTime';
  static const categories = 'categories';
  static const ownerEmail = 'ownerEmail';
  static const ownerMobile = 'ownerMobile';
  static const ownerName = 'ownerName';
  static const totalDelivery = 'totalDelivery';
  static const openingTime = 'openingTime';
  static const closingTime = 'closingTime';
  static const isClosed = 'isClosed';
  static const isOpen = 'isOpen';
  static const imageUrl = 'imageUrl';
  static const createdBy = 'createdBy';
  static const updatedBy = 'updatedBy';
  static const baseDeliveryCharge = 'baseDeliveryCharge';
  static const baseDeliveryKM = 'baseDeliveryKM';
  static const radiusKM = 'radiusKM';
  static const perKM = 'perKM';
  static const freeDeliveryKM = 'freeDeliveryKM';
  static const balance = 'balance';
  static const verificationStatus = 'verificationStatus';
  static const panVAT = 'panVAT';
  static const address = 'address';
  static const activeStatus = 'activeStatus';
  static const lastActive = 'lastActive';
  static const role = 'role';
  static const transferredBy = 'transferredBy';
  static const nutritions = 'nutritions';
  const Fields._();
}

@immutable
class LocationStrings {
  static const enablelocation = 'Enable Location';
  static const genericMessage =
      'Make sure to allow location service in order to access the app';
  static const locationDenied =
      'Location permissions are denied. Please enable from app setting to continue.';
  static const locationDeniedPermanently =
      'Location permissions are permanently denied, we cannot request permissions. Please enable from app setting to continue browsing.';
  static const locationLimited =
      'Location permission is limited. Please provide full access.';
  static const locationUnexpectedError =
      'An unexpected error occurred while requesting location permissions.';
  static const useMyCurrentLocationTitle = 'Use My Current Location';
  static const useMyCurrentLocationDesc =
      'Enjoy hot meals delivered right to your doorstep';
  static const useManualLocationTitle = 'Enter Address Manually';
  static const useMManualLocationDesc =
      'Type your address to find delivery options nearby.';
  const LocationStrings._();
}
