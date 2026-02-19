import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/profile/domain/repository/favorite_repository.dart';
import 'package:get/get.dart';

class FavorateController extends GetxController {
  // ----------------------------- REPOSITORY -----------------------------
  final FavoriteRepository favoriteRepository = FavoriteRepository.instance;

  // ----------------------------- VARIABLES -----------------------------
  RxBool isLoading = false.obs;

  RxList<FavoriteCardEntity> favoriteCardEntityList =
      <FavoriteCardEntity>[].obs;

  /// ----------------------------- FUNCTIONS -----------------------------
  @override
  void onInit() {
    super.onInit();
    getFavoriteCardEntityList();
  }

  /// ----------------------------- FUNCTIONS -----------------------------
  Future<void> getFavoriteCardEntityList() async {
    try {
      isLoading.value = true;
      final result = await favoriteRepository.getFavoriteCardEntityList();
      favoriteCardEntityList.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(int index) {
    final item = favoriteCardEntityList[index];

    favoriteCardEntityList[index] = FavoriteCardEntity(
      image: item.image,
      name: item.name,
      address: item.address,
      status: item.status,
      isFavorite: !(item.isFavorite ?? false),
    );

    favoriteCardEntityList.refresh();
    update();
  }
}
