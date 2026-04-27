## Goal
এই repo-র existing convention অনুযায়ী code generate/modify করতে হবে: **Flutter + GetX + Dio + GetStorage + ScreenUtil + Feature-first architecture**।

## Language policy
- Instruction হবে **Bangla**।
- Technical terms **English** এ রাখতে হবে (GetX, Controller, Repository, Model, Widget, Route, Binding, etc.)।

## Non‑negotiable project structure
- `lib/` top-level split MUST:
  - `lib/core/` = shared infrastructure + reusable components
  - `lib/feature/` = feature modules
  - `lib/main.dart`, `lib/my_app.dart` = app entry & root
- Feature module structure MUST:
  - `lib/feature/<feature>/domain/model/` = API models (`fromJson/toJson`)
  - `lib/feature/<feature>/domain/entity/` = UI-friendly entities (only when needed)
  - `lib/feature/<feature>/domain/repository/` = Repository (singleton `instance`)
  - `lib/feature/<feature>/presentation/controller/` = GetX controllers
  - `lib/feature/<feature>/presentation/ui/` = screens/pages
  - `lib/feature/<feature>/presentation/widget/` = feature reusable widgets

## Folder structure (reference tree)

Cursor MUST follow this structure when creating new code (keep names consistent).

```text
assets/
  images/
  icons/
lib/
  main.dart
  my_app.dart
  core/
    component/
      appbar/
      app_button/
      app_text/
      app_input/
      app_image/
      app_location_field/
      app_webview/
    const/
    route/
      bindings/
    service/
      api_service/
      location_service/
    theme/
    utils/
  feature/
    <feature_name>/
      domain/
        model/
        entity/
        repository/
      presentation/
        controller/
        ui/
        widget/
```

## Placement rules (where to put what)
- **Shared components** (AppBar/Button/Text/Input/Image/Dialog/BottomSheet/Dropdown): `lib/core/component/<component_name>/`
- **Shared constants** (colors/assets/strings): `lib/core/const/`
- **Shared helpers** (logger/snackbar/date/time): `lib/core/utils/`
- **Shared services** (api/storage/location): `lib/core/service/`
- **Feature screen**: `lib/feature/<feature>/presentation/ui/<name>_screen.dart`
- **Feature controller**: `lib/feature/<feature>/presentation/controller/<name>_controller.dart`
- **Feature widgets**: `lib/feature/<feature>/presentation/widget/<name>.dart`
- **Feature models**: `lib/feature/<feature>/domain/model/<name>_model.dart`
- **Feature entities**: `lib/feature/<feature>/domain/entity/<name>_entity.dart` (only when needed)
- **Feature repository**: `lib/feature/<feature>/domain/repository/<feature>_repository.dart`

## Naming conventions (strict)
- file/folder: `snake_case`
  - example: `pickup_location_controller.dart`, `wallet_history_screen.dart`
- class: `PascalCase`
  - example: `PickupLocationWithGetShopController`, `NewOrderRepository`
- suffix rules:
  - Controllers: `...Controller`
  - Screens: `...Screen`
  - Repositories: `...Repository`

## Boot sequence rules
- `main.dart` MUST include:
  - `WidgetsFlutterBinding.ensureInitialized()`
  - `await GetStorage.init()`
- Root app MUST be:
  - `ScreenUtilInit(designSize: Size(393, 852))`
  - `GetMaterialApp(...)`
  - `initialBinding: AppBinding()`
  - `getPages: appRootRoutesFile`
  - token/guest based `initialRoute` logic (project convention)

## Routing rules (GetX)
- New screen add করলে:
  - route name add করতে হবে `lib/core/route/app_routes.dart` এ
  - `GetPage(...)` add করতে হবে `lib/core/route/app_routes_file.dart` এ
  - controller/DI লাগলে `AppBinding` বা `AuthBinding` এ `Get.lazyPut` দিয়ে inject করতে হবে
- Navigation MUST use:
  - `Get.toNamed(...)`, `Get.back()`, `Get.offAllNamed(...)`

## State management rules (GetX)
- Screen layer:
  - page root এ `GetBuilder<Controller>(init: Controller(), builder: ...)`
  - reactive sub-tree এ `Obx(() => ...)`
- Controller layer:
  - UI state: `RxBool`, `RxInt`, `RxString`, `RxList<T>`, `Rxn<T>`
  - async pattern MUST:
    - `try { isLoading.value = true; ... } finally { isLoading.value = false; }`
  - `TextEditingController` থাকলে `onClose()` এ `dispose()` করতে হবে

## Repository + API rules
- HTTP MUST go through `ApiServices` / Dio wrappers (UI/Controller এ direct Dio call যাবে না)
- Endpoint strings MUST live in `lib/core/service/api_service/app_api_end_point.dart`
- Repository MUST be singleton:
  - `Repository._(); static final _instance; static get instance => _instance;`
- Model parsing MUST happen in repository/model layer (UI/Controller এ raw json avoid)

## Models rules
- Models MUST be plain Dart classes with:
  - `factory ...fromJson(Map<String, dynamic> json)`
  - `Map<String, dynamic> toJson()`
- Defensive parsing:
  - null checks + `is Map` / `is List` checks when API uncertain

## Reusable UI rules (default custom components)
- Common UI MUST use core components:
  - text: `AppText`
  - button: `AppButton`
  - appbar: `CustomAppbar`
  - toast/snackbar: `AppSnackBar`
- New shared component হলে `lib/core/component/<component>/` এ রাখবে
- Feature-only reusable widget হলে `lib/feature/<feature>/presentation/widget/` এ রাখবে

## Images → Flutter UI policy (mandatory)
- user যদি screenshot/mock/image দেয়:
  - UI implement করবে Flutter code এ
  - Layout responsive হবে `ScreenUtil` দিয়ে (`.w/.h/.sp`)
  - repeated UI blocks MUST be extracted as reusable widgets
    - shared হলে `core/component`
    - feature-only হলে `feature/.../presentation/widget`
- assets MUST live in:
  - `assets/images/` or `assets/icons/`

## Dialog / BottomSheet / Dropdown policy
- Raw `showDialog` / `showModalBottomSheet` scattered use avoid করবে
- Prefer default wrappers:
  - `AppDialog` (confirm/success/error)
  - `AppBottomSheet` (standard padding, radius, SafeArea)
  - `AppDropdown` (consistent style)

## Boundaries (strict)
- UI screens MUST NOT call network directly
- Controllers MUST NOT contain heavy JSON parsing
- Repositories MUST NOT import UI/widgets
- `core/` SHOULD NOT import `feature/` (avoid cycles)

