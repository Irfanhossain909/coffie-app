# Coffie Flutter Project Structure (GetX + Feature-first)

এই document টা এই repo-র **বর্তমান folder/file structure** এবং **team convention** capture করে—যাতে নতুন feature add/maintain করতে একই pattern follow করা যায়।

## High-level layout

```text
assets/
  images/
  icons/
lib/
  core/
  feature/
  main.dart
  my_app.dart
```

## Core entrypoints

- `lib/main.dart`
  - `WidgetsFlutterBinding.ensureInitialized()`
  - `GetStorage.init()`
  - orientation lock
  - `runApp(MyApp())`
- `lib/my_app.dart`
  - `ScreenUtilInit(designSize: Size(393, 852))`
  - `GetMaterialApp`
  - `initialBinding: AppBinding()`
  - `getPages: appRootRoutesFile`
  - token/guest based dynamic `initialRoute`

## `lib/core/` (shared infrastructure)

```text
lib/core/
  component/          # reusable UI building blocks
  const/              # constants (colors/assets/strings)
  route/              # routes + GetPage table + bindings
  service/            # api + storage + location services
  theme/              # app theme
  utils/              # logger/snackbar/date-time helpers
```

### `lib/core/component/` (default reusable widgets)

```text
lib/core/component/
  appbar/
    custom_appbar.dart
  app_button/
    app_button.dart
  app_text/
    app_text.dart
  app_input/
    app_input_widget_two.dart
    add_descreption_text_field.dart
  app_image/
    app_image_circular.dart
  app_location_field/
    places_suggation.dart
    location_utils.dart
    location_repository.dart
  app_webview/
    stripe_web_view_page.dart
```

### `lib/core/route/` (GetX navigation)

```text
lib/core/route/
  app_routes.dart           # string route names
  app_routes_file.dart      # List<GetPage> table
  bindings/
    app_binding.dart        # main dependency injection (Get.lazyPut)
    auth_binding.dart       # auth related DI
    splash_screen_binding.dart
    navigation_screen_binding.dart
```

### `lib/core/service/` (network, storage, location)

```text
lib/core/service/
  api_service/
    api.dart
    api_services.dart
    app_api_end_point.dart
    app_in_put_unfocused.dart
    app_storage_key.dart
    get_storage_services.dart
    non_auth_api.dart
  location_service/
    location_service.dart
```

## `lib/feature/` (Feature-first modules)

প্রতিটা feature সাধারণত এই structure follow করে:

```text
lib/feature/<feature_name>/
  domain/
    model/        # API models (fromJson/toJson)
    entity/       # UI-friendly entities (when needed)
    repository/   # repository singleton
  presentation/
    controller/   # GetxController
    ui/           # screens
    widget/       # feature reusable widgets
```

### Current features (as-is)

```text
lib/feature/
  auth/
  favorite/
  geust/
  gift_card/
  home/
  navigation/
  new_order/
  notification/
  onboarding/
  order/
  profile/
  reward/
  splash/
  wallet/
```

### Example: `new_order`

```text
lib/feature/new_order/
  domain/
    entity/
      add_to_cart_entity.dart
    model/
      cart_item_model.dart
      cart_summary_model.dart
      shop_categoty_model.dart
      single_product_model.dart
      store_model.dart
      store_product_model.dart
    repository/
      new_order_repository.dart
  presentation/
    controller/
      my_cart_controller.dart
      pickup_location_controller.dart
      product_info_controller.dart
      shop_order_information_controller.dart
    ui/
      pickup_location_screen.dart
      shop_details_screnn.dart
      shop_order_information_screen.dart
      product_info_screen.dart
      my_cart_screen.dart
    widget/
      home_map_preview.dart
      product_card.dart
      payment_card.dart
      reward_point_input.dart
      ...
```

## Where to place new code (rules-of-thumb)

- **New shared UI component** (AppBar/Button/Dialog/BottomSheet/Dropdown, etc.)
  - `lib/core/component/<name>/...`
- **New feature screen**
  - `lib/feature/<feature>/presentation/ui/<screen>_screen.dart`
- **New feature controller**
  - `lib/feature/<feature>/presentation/controller/<name>_controller.dart`
- **New API model**
  - `lib/feature/<feature>/domain/model/<name>_model.dart`
- **New repository method**
  - `lib/feature/<feature>/domain/repository/<feature>_repository.dart`
  - endpoint update in `lib/core/service/api_service/app_api_end_point.dart`
- **New route**
  - add name in `lib/core/route/app_routes.dart`
  - add `GetPage` in `lib/core/route/app_routes_file.dart`
  - ensure DI via `AppBinding`/`AuthBinding`

