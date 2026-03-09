# 🎯 Skin Care App - Clean Architecture Implementation

تم إعادة هيكلة المشروع وفقاً لنمط **Clean Architecture** الذي يوفر:

- ✅ فصل واضح للمسؤوليات
- ✅ سهولة الاختبار والصيانة
- ✅ إمكانية إعادة الاستخدام
- ✅ قابلية التوسع

---

## 📁 هيكل المشروع الكامل

```
skin_care_app/
│
├── lib/
│   ├── config/                          # 🔧 الإعدادات
│   │   ├── routes.dart                 # توجيه الشاشات
│   │   └── service_locator.dart        # حقن الاعتماديات
│   │
│   ├── core/                            # 🔌 المشترك
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── errors/
│   │   │   ├── exceptions.dart         # استثناءات مخصصة
│   │   │   └── failures.dart           # أخطاء مخصصة
│   │   └── utils/
│   │       └── logger.dart             # تسجيل البيانات
│   │
│   ├── data/                            # 📦 طبقة البيانات
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   └── skin_local_data_source.dart
│   │   │   └── remote/
│   │   │       └── skin_remote_data_source.dart
│   │   ├── models/
│   │   │   └── skin_product_model.dart
│   │   └── repositories/
│   │       └── skin_product_repository_impl.dart
│   │
│   ├── domain/                          # 🎓 طبقة المنطق
│   │   ├── entities/
│   │   │   └── skin_product.dart
│   │   ├── repositories/
│   │   │   └── skin_product_repository.dart
│   │   └── usecases/
│   │       ├── get_all_products_usecase.dart
│   │       ├── get_product_by_id_usecase.dart
│   │       └── search_products_usecase.dart
│   │
│   ├── presentation/                   # 🎨 طبقة العرض
│   │   ├── bloc/
│   │   │   ├── skin_product_bloc.dart
│   │   │   ├── skin_product_event.dart
│   │   │   └── skin_product_state.dart
│   │   ├── pages/
│   │   │   ├── home_page.dart
│   │   │   └── product_detail_page.dart
│   │   └── widgets/
│   │       ├── app_bar_widget.dart
│   │       └── product_card.dart
│   │
│   └── main.dart                       # 🚀 نقطة الدخول
│
├── test/
│   └── example_test.dart               # 🧪 أمثلة اختبار
│
├── pubspec.yaml                        # 📋 المكتبات
├── CLEAN_ARCHITECTURE.md               # 📖 الدليل الشامل
├── IMPLEMENTATION_EXAMPLE.dart         # 💡 أمثلة عملية
└── README.md                            # هذا الملف
```

---

## 🚀 الخطوات التالية

### 1️⃣ تثبيت المكتبات

```bash
cd skin_care_app
flutter pub get
```

### 2️⃣ تطبيق Remote Data Source

أكمل تطبيق API في:

```
lib/data/datasources/remote/skin_remote_data_source.dart
```

**مثال:**

```dart
class SkinRemoteDataSourceImpl implements SkinRemoteDataSource {
  final http.Client httpClient;

  @override
  Future<List<SkinProductModel>> getAllProducts() async {
    final response = await httpClient.get(
      Uri.parse('${AppConstants.baseUrl}/products'),
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((p) => SkinProductModel.fromJson(p))
          .toList();
    } else {
      throw ServerException('Failed to load products');
    }
  }
}
```

### 3️⃣ تطبيق Local Data Source

أكمل تطبيق التخزين المحلي في:

```
lib/data/datasources/local/skin_local_data_source.dart
```

**مثال باستخدام SharedPreferences:**

```dart
class SkinLocalDataSourceImpl implements SkinLocalDataSource {
  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheAllProducts(List<SkinProductModel> products) async {
    final jsonString = json.encode(
      products.map((m) => m.toJson()).toList(),
    );
    await sharedPreferences.setString(
      AppConstants.cachedProducts,
      jsonString,
    );
  }

  @override
  Future<List<SkinProductModel>> getAllProducts() async {
    final jsonString = sharedPreferences.getString(
      AppConstants.cachedProducts,
    );
    if (jsonString != null) {
      return (json.decode(jsonString) as List)
          .map((p) => SkinProductModel.fromJson(p))
          .toList();
    } else {
      throw CacheException('No cached products');
    }
  }
}
```

### 4️⃣ إعداد Dependency Injection

أكمل الإعدادات في:

```
lib/config/service_locator.dart
```

**مثال:**

```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Data Sources
  getIt.registerSingleton<SkinRemoteDataSource>(
    SkinRemoteDataSourceImpl(httpClient: http.Client()),
  );

  getIt.registerSingleton<SkinLocalDataSource>(
    SkinLocalDataSourceImpl(
      sharedPreferences: SharedPreferences.getInstance(),
    ),
  );

  // Repository
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

### 5️⃣ تحديث main.dart

استخدم الـ DI:

```dart
import 'config/service_locator.dart';
import 'presentation/bloc/skin_product_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SkinProductBloc>(),
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
```

### 6️⃣ تطبيق الصفحات والـ Widgets

- استكمل `HomePage` مع ربط BLoC
- أضف `ProductDetailPage`
- صمم `CustomWidgets` حسب احتياجاتك

---

## 📚 الملفات التوثيقية

### 📖 CLEAN_ARCHITECTURE.md

شرح مفصل لـ Clean Architecture يتضمن:

- شرح كل طبقة
- تدفق البيانات
- أمثلة عملية
- أفضل الممارسات

### 💡 IMPLEMENTATION_EXAMPLE.dart

أمثلة كاملة توضح:

- كيفية إنشاء Entity
- كيفية كتابة Model
- كيفية تطبيق Repository
- كيفية استخدام BLoC
- كيفية إعداد DI

### 🧪 test/example_test.dart

أمثلة على الاختبارات:

- اختبار Use Case
- اختبار BLoC
- اختبار Repository

---

## 🎨 Feature برای اضافی

جاهز للإضافات:

```
lib/domain/usecases/
├── add_product_usecase.dart          # إضافة منتج (TODO)
├── update_product_usecase.dart       # تحديث منتج (TODO)
└── delete_product_usecase.dart       # حذف منتج (TODO)

lib/presentation/pages/
├── favorites_page.dart               # صفحة المفضلة (TODO)
├── cart_page.dart                    # صفحة السلة (TODO)
└── checkout_page.dart                # صفحة الدفع (TODO)
```

---

## ⚙️ المكتبات المستخدمة

| المكتبة              | الإصدار | الغرض                |
| -------------------- | ------- | -------------------- |
| `flutter_bloc`       | ^8.1.6  | إدارة الحالة         |
| `bloc`               | ^8.1.4  | BLoC library         |
| `equatable`          | ^2.0.5  | مقارنة الكائنات      |
| `dartz`              | ^0.10.1 | Either/Option        |
| `get_it`             | ^7.6.0  | Dependency Injection |
| `http`               | ^1.1.0  | HTTP calls           |
| `shared_preferences` | ^2.2.2  | Local storage        |
| `intl`               | ^0.19.0 | Localization         |
| `flutter_lints`      | ^6.0.0  | Code quality         |
| `mockito`            | ^5.4.4  | Testing              |
| `build_runner`       | ^2.4.7  | Code generation      |

---

## 🧪 تشغيل الاختبارات

```bash
# تشغيل جميع الاختبارات
flutter test

# تشغيل اختبار محدد
flutter test test/example_test.dart

# تشغيل مع تقرير Coverage
flutter test --coverage
```

---

## 📋 قائمة التحقق

- [ ] تثبيت المكتبات (`flutter pub get`)
- [ ] تطبيق `SkinRemoteDataSourceImpl`
- [ ] تطبيق `SkinLocalDataSourceImpl`
- [ ] إعدادات Dependency Injection
- [ ] تحديث `main.dart`
- [ ] ربط الصفحات بـ Routes
- [ ] اختبار التطبيق (`flutter run`)
- [ ] كتابة الاختبارات
- [ ] إضافة Features جديدة

---

## 🔗 روابط مفيدة

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Dartz Package](https://pub.dev/packages/dartz)
- [GetIt Package](https://pub.dev/packages/get_it)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)

---

## 💬 ملاحظات مهمة

✅ **الفوائد:**

- عزل الأكواد - كل طبقة مستقلة
- سهولة الاختبار - يمكن اختبار كل حاجة بدون تبعيات
- إعادة استخدام الكود - logic الأعمال منفصل عن UI
- صيانة سهلة - تغيير API بدون تأثر الـ UI
- قابل للتوسع - إضافة features جديدة بسهولة

⚠️ **التحديات:**

- الملفات الكثيرة - قد يبدو معقداً أول مرة
- الحفاظ على النمط - يتطلب انضباط
- منحنى التعلم - يحتاج وقت للتعود عليها

---

## 📞 المساعدة

إذا واجهت أي مشاكل:

1. اقرأ `CLEAN_ARCHITECTURE.md`
2. اطلع على `IMPLEMENTATION_EXAMPLE.dart`
3. تحقق من أمثلة الاختبارات

---

**تم إنشاء هيكل Clean Architecture كامل جاهز للاستخدام! 🎉**

استمتع ببناء تطبيقك! 🚀
