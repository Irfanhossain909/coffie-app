import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/order/domain/model/order_card_model.dart';

class OrderRepository {
  OrderRepository._();
  static final OrderRepository _instance = OrderRepository._();
  static OrderRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<List<OrderCardDataModel>> getOrderList({
    required String orderType,
    int? page,
    int? limit,
  }) async {
    List<OrderCardDataModel> orderList = <OrderCardDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.orderList(orderType),
        queryParameters: {"page": page, "limit": limit},
      );
      if (response != null && response is Map<String, dynamic>) {
        for (var order in response["data"]) {
          orderList.add(OrderCardDataModel.fromJson(order));
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return orderList;
  }
}
