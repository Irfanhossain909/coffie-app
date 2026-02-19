import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';

class FavoriteRepository {
  FavoriteRepository._();
  static final FavoriteRepository _instance = FavoriteRepository._();
  static FavoriteRepository get instance => _instance;

  Future<List<FavoriteCardEntity>> getFavoriteCardEntityList() async {
    await Future.delayed(const Duration(seconds: 2));
    return favoriteCardEntityList;
  }
}
