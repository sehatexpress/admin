// ignore_for_file: constant_identifier_names

enum OrderStatusEnum {
  ordered,
  accepted,
  confirmed,
  picked,
  delivered,
  cancelled,
}

enum FilterEnum { all, veg, nonVeg, both, bestSeller }

enum MessageType { neutral, error, success }

enum TicketStatusEnum { pending, inProcess, closed }

enum RoleEnum {
  super_admin,
  admin,
  sub_admin,
  accountant,
}

enum MenuTypeEnum { veg, non_veg, both }

enum CommissionTypeEnum { flat, percentage }

enum VerificationStatusEnum { pending, verified }

enum OrderPlatformEnum { web, mobile }
