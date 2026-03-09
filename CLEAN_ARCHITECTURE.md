# Skin Care App - Clean Architecture

## مقدمة عن Clean Architecture

هذا المشروع يتبع نمط **Clean Architecture** الذي يفصل التطبيق إلى طبقات مستقلة، كل واحدة لها مسؤوليات محددة.

## 🏗️ هيكل المشروع

```
lib/
├── config/                      # Configuration Files
│   ├── routes.dart             # App Routes
│   └── service_locator.dart    # Dependency Injection
│
├── core/                        # Core Utilities & Shared Code
│   ├── constants/
│   │   └── app_constants.dart  # App Constants
│   ├── errors/
│   │   ├── exceptions.dart     # Exception Classes
│   │   └── failures.dart       # Failure Classes
│   └── utils/
│       └── logger.dart         # Logger Utility
│
├── data/                        # Data Layer
│   ├── datasources/
│   │   ├── local/
│   │   │   └── skin_local_data_source.dart    # Local Data (Cache/DB)
│   │   └── remote/
│   │       └── skin_remote_data_source.dart   # Remote Data (API)
│   ├── models/
│   │   └── skin_product_model.dart            # Data Models with JSON
│   └── repositories/
│       └── skin_product_repository_impl.dart  # Repository Implementation
│
├── domain/                      # Domain Layer (Business Logic)
│   ├── entities/
│   │   └── skin_product.dart               # Domain Entities
│   ├── repositories/
│   │   └── skin_product_repository.dart    # Repository Interfaces
│   └── usecases/
│       ├── get_all_products_usecase.dart
│       ├── get_product_by_id_usecase.dart
│       └── search_products_usecase.dart
│
├── presentation/                # Presentation Layer (UI)
│   ├── bloc/
│   │   ├── skin_product_bloc.dart       # BLoC Logic
│   │   ├── skin_product_event.dart      # BLoC Events
│   │   └── skin_product_state.dart      # BLoC States
│   ├── pages/
│   │   ├── home_page.dart
│   │   └── product_detail_page.dart
│   └── widgets/
│       ├── app_bar_widget.dart
│       └── product_card.dart
│
└── main.dart                    # App Entry Point
```

## 📋 شرح الطبقات

### 1. **Presentation Layer** (طبقة العرض)
- **المسؤولية**: عرض البيانات على المستخدم والتعامل مع إدخاله
- **المكونات**:
  - `Pages`: الصفحات الرئيسية
  - `Widgets`: مكونات UI قابلة لإعادة الاستخدام
  - `BLoC`: إدارة حالة التطبيق

```dart
// مثال على الاستخدام
BlocBuilder<SkinProductBloc, SkinProductState>(
  builder: (context, state) {
    if (state is SkinProductLoaded) {
      return ListView(children: state.products);
    }
    return CircularProgressIndicator();
  },
);
```

### 2. **Domain Layer** (طبقة المنطق)
- **المسؤولية**: تعريف قواعد العمل والمنطق الأساسي
- **المكونات**:
  - `Entities`: كائنات البيانات المستقلة
  - `Repositories`: واجهات (Interfaces) للمستودعات
  - `Use Cases`: حالات الاستخدام

```dart
// مثال على Use Case
class GetAllProductsUseCase {
  final SkinProductRepository repository;
  
  Future<Either<Failure, List<SkinProduct>>> call() async {
    return await repository.getAllProducts();
  }
}
```

### 3. **Data Layer** (طبقة البيانات)
- **المسؤولية**: إنجاز عمليات جلب وحفظ البيانات
- **المكونات**:
  - `Models`: نماذج البيانات مع JSON Serialization
  - `Repositories Implementation`: تنفيذ الواجهات
  - `Data Sources`: مصادر البيانات (Remote/Local)

```dart
// مثال على Data Source
class SkinRemoteDataSourceImpl implements SkinRemoteDataSource {
  Future<List<SkinProductModel>> getAllProducts() async {
    // استدعاء API
    final response = await http.get(Uri.parse(apiUrl));
    return (json.decode(response.body) as List)
        .map((p) => SkinProductModel.fromJson(p))
        .toList();
  }
}
```

### 4. **Core Layer** (طبقة المشترك)
- **المسؤولية**: أدوات وثوابت مشتركة بين جميع الطبقات
- **المكونات**:
  - `Constants`: الثوابت
  - `Errors`: فئات الأخطاء والاستثناءات
  - `Utils`: أدوات مساعدة

## 🔄 تدفق البيانات

```
User Interaction (UI)
        ↓
  BLoC Event
        ↓
  Use Case
        ↓
  Repository
        ↓
  Data Source (Remote/Local)
        ↓
  API / Database
        ↓
  Data Source
        ↓
  Repository
        ↓
  BLoC State
        ↓
  UI Update
```

## 💾 Dependency Injection

استخدم `get_it` لإدارة المسؤولين:

```dart
// في service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // Data Sources
  getIt.registerSingleton<SkinRemoteDataSource>(
    SkinRemoteDataSourceImpl(),
  );
  
  // Repositories
  getIt.registerSingleton<SkinProductRepository>(
    SkinProductRepositoryImpl(
      remoteDateSource: getIt(),
      localDataSource: getIt(),
    ),
  );
  
  // Use Cases
  getIt.registerSingleton<GetAllProductsUseCase>(
    GetAllProductsUseCase(getIt()),
  );
  
  // BLoC
  getIt.registerSingleton<SkinProductBloc>(
    SkinProductBloc(
      getAllProductsUseCase: getIt(),
      getProductByIdUseCase: getIt(),
      searchProductsUseCase: getIt(),
    ),
  );
}
```

## 📦 المكتبات المستخدمة

| المكتبة | الغرض |
|---------|-------|
| `flutter_bloc` | إدارة الحالة |
| `equatable` | المقارنة البسيطة للكائنات |
| `dartz` | البرمجة الوظيفية (Either) |
| `get_it` | Dependency Injection |
| `http` | استدعاءات API |
| `shared_preferences` | تخزين محلي بسيط |

## 🚀 بدء العمل

### 1. تثبيت المكتبات
```bash
flutter pub get
```

### 2. تطبيق Dependency Injection
قم بتنفيذ `setupServiceLocator()` في `main.dart`

### 3. تطبيق Data Sources
أكمل تطبيق `SkinRemoteDataSourceImpl` و `SkinLocalDataSourceImpl`

### 4. اختبار التطبيق
```bash
flutter test
```

## 🎯 المميزات

✅ **Testability** - سهل الاختبار لأن كل طبقة مستقلة
✅ **Maintainability** - سهل الصيانة والتطوير
✅ **Scalability** - يمكن التوسع بسهولة
✅ **Reusability** - إعادة استخدام الكود بسهولة
✅ **Separation of Concerns** - فصل الاهتمامات بوضوح

## 📝 ملاحظات مهمة

- كل طبقة لا تعتمد على الطبقات الأعلى منها (للأسفل فقط)
- Data Layer و Presentation Layer لا يعتمدان على بعضهما مباشرة
- Domain Layer لا يعتمد على أي إطار عمل خارجي
- استخدم `Either<Failure, Success>` للتعامل مع الأخطاء

## 📚 مراجع إضافية

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Pattern](https://bloclibrary.dev/)
- [Functional Programming with Dartz](https://pub.dev/packages/dartz)
