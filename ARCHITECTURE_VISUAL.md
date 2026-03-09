# 📊 Clean Architecture - Visual Structure

## 🎯 هيكل الملفات الكامل

```
skin_care_app/
│
├── lib/                                    # الكود الرئيسي
│   │
│   ├── 🔌 core/                          # الطبقة المشتركة
│   │   ├── constants/
│   │   │   └── app_constants.dart        # ثوابت التطبيق
│   │   ├── errors/
│   │   │   ├── exceptions.dart           # استثناءات مخصصة
│   │   │   └── failures.dart             # أنواع الأخطاء (Either)
│   │   └── utils/
│   │       └── logger.dart               # Logger للتصحيح
│   │
│   ├── 🎓 domain/                        # طبقة المنطق (Domain)
│   │   ├── entities/
│   │   │   └── skin_product.dart         # Entity (مستقل عن الإطار)
│   │   ├── repositories/
│   │   │   └── skin_product_repository.dart  # واجهة (Abstract)
│   │   └── usecases/
│   │       ├── get_all_products_usecase.dart
│   │       ├── get_product_by_id_usecase.dart
│   │       └── search_products_usecase.dart
│   │
│   ├── 📦 data/                          # طبقة البيانات (Data)
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   └── skin_local_data_source.dart   # Cache/Database
│   │   │   └── remote/
│   │   │       └── skin_remote_data_source.dart  # API
│   │   ├── models/
│   │   │   └── skin_product_model.dart   # Model (مع JSON)
│   │   └── repositories/
│   │       └── skin_product_repository_impl.dart # Implementation
│   │
│   ├── 🎨 presentation/                 # طبقة العرض (UI)
│   │   ├── bloc/
│   │   │   ├── skin_product_bloc.dart    # BLoC Logic
│   │   │   ├── skin_product_event.dart   # Events
│   │   │   └── skin_product_state.dart   # States
│   │   ├── pages/
│   │   │   ├── home_page.dart            # الصفحة الرئيسية
│   │   │   └── product_detail_page.dart  # تفاصيل المنتج
│   │   └── widgets/
│   │       ├── app_bar_widget.dart       # App Bar مخصص
│   │       └── product_card.dart         # بطاقة المنتج
│   │
│   ├── 🔧 config/                       # الإعدادات
│   │   ├── routes.dart                  # التوجيه
│   │   └── service_locator.dart         # Dependency Injection
│   │
│   └── main.dart                        # 🚀 نقطة البدء
│
├── test/                                # الاختبارات
│   └── example_test.dart                # أمثلة الاختبارات
│
├── pubspec.yaml                         # 📋 المكتبات
├── QUICK_START.md                       # ⚡ البدء السريع
├── README_SETUP.md                      # 📖 دليل الإعداد
├── CLEAN_ARCHITECTURE.md                # 📚 الشرح المفصل
├── ARCHITECTURE_SUMMARY.md              # 📊 الملخص
└── IMPLEMENTATION_EXAMPLE.dart          # 💡 أمثلة عملية
```

---

## 📊 العلاقات بين الطبقات

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃          PRESENTATION LAYER               ┃
┃        (UI, Pages, Widgets, BLoC)         ┃
┃                                          ┃
┃  ┌──────────────────────────────────┐  ┃
┃  │       Home Page (UI)             │  ┃
┃  │  - Search Bar                    │  ┃
┃  │  - Product Grid                  │  ┃
┃  └────────────────┬─────────────────┘  ┃
┃                   │                    ┃
┃  ┌────────────────▼─────────────────┐  ┃
┃  │   SkinProductBloc (State Manager)│  ┃
┃  │  - Events: GetAll, Search, etc.  │  ┃
┃  │  - States: Loading, Loaded, Error│  ┃
┃  └────────────────┬─────────────────┘  ┃
┗━━━━━━━━━━━━━━━━━┃━━━━━━━━━━━━━━━━━━━━━━┛
                   │
                   ▼
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃            DOMAIN LAYER                    ┃
┃   (Business Logic, Independent of UI)      ┃
┃                                          ┃
┃  ┌──────────────────────────────────┐  ┃
┃  │    GetAllProductsUseCase         │  ┃
┃  │  - Repository call               │  ┃
┃  │  - Error handling                │  ┃
┃  └────────────────┬─────────────────┘  ┃
┃                   │                    ┃
┃  ┌────────────────▼─────────────────┐  ┃
┃  │   SkinProductRepository          │  ┃
┃  │  (Abstract Interface)            │  ┃
┃  │  - getAllProducts()              │  ┃
┃  │  - getProductById()              │  ┃
┃  │  - searchProducts()              │  ┃
┃  └────────────────┬─────────────────┘  ┃
┃                   │                    ┃
┃  ┌────────────────▼─────────────────┐  ┃
┃  │    SkinProduct Entity            │  ┃
┃  │  - id, name, price, rating, etc. │  ┃
┃  │  (Framework Independent)         │  ┃
┃  └──────────────────────────────────┘  ┃
┗━━━━━━━━━━━━━━━━━┃━━━━━━━━━━━━━━━━━━━━━━┛
                   │
                   ▼
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃             DATA LAYER                     ┃
┃  (Data Handling, Models, Repositories)      ┃
┃                                          ┃
┃  ┌──────────────────────────────────┐  ┃
┃  │ SkinProductRepositoryImpl         │  ┃
┃  │  - Implements abstract interface │  ┃
┃  │  - Coordinates data sources      │  ┃
┃  │  - Transforms Models → Entities  │  ┃
┃  └────────┬──────────────┬──────────┘  ┃
┃           │              │             ┃
┃  ┌────────▼──┐   ┌───────▼────────┐  ┃
┃  │  Remote   │   │     Local      │  ┃
┃  │ DataSource│   │   DataSource   │  ┃
┃  │  (API)    │   │   (Cache/DB)   │  ┃
┃  └────────┬──┘   └───────┬────────┘  ┃
┃           │              │             ┃
┃  ┌────────▼──────────────▼────────┐  ┃
┃  │    SkinProductModel            │  ┃
┃  │  - JSON serialization          │  ┃
┃  │  - Extends SkinProduct Entity  │  ┃
┃  │  - toEntity() → SkinProduct    │  ┃
┃  └───────────────────────────────┘  ┃
┗━━━━━━━━━━━━━━━━━┃━━━━━━━━━━━━━━━━━━━┛
                   │
                   ▼
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃            EXTERNAL LAYER                  ┃
┃         (APIs & Local Storage)              ┃
┃                                          ┃
┃  ┌──────────────┐   ┌──────────────┐  ┃
┃  │   REST API   │   │  Local Cache │  ┃
┃  │              │   │  (SharedPref)│  ┃
┃  └──────────────┘   └──────────────┘  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## 🔄 Data Flow - تدفق البيانات

```
1️⃣ USER INTERACTION (في الـ UI)
   ├─ User clicks "Load Products" button
   └─ HomePage calls: context.read<SkinProductBloc>()
                        .add(GetAllProductsEvent())

2️⃣ BLoC PROCESSING
   ├─ BLoC receives GetAllProductsEvent
   ├─ Emits SkinProductLoading state
   └─ Calls getAllProductsUseCase()

3️⃣ USE CASE EXECUTION
   ├─ Use Case receives request
   └─ Calls repository.getAllProducts()

4️⃣ REPOSITORY LOGIC
   ├─ Try Remote DataSource (API)
   │  ├─ Success? → Cache locally + Return
   │  └─ Failure? → Go to step 5
   │
   ├─ Try Local DataSource (Cache)
   │  ├─ Success? → Return cached data
   │  └─ Failure? → Go to step 5
   │
   └─ Return failure Either<Failure, List>

5️⃣ ERROR HANDLING
   ├─ Wrap in Either<Failure, Success>
   ├─ No exceptions thrown
   └─ Return error safely

6️⃣ DATA TRANSFORMATION
   ├─ Models → Entities (in Repository)
   └─ Return pure domain objects

7️⃣ BLoC STATE EMISSION
   ├─ On Success: emit SkinProductLoaded(products)
   ├─ On Failure: emit SkinProductError(message)
   └─ UI listens to state changes

8️⃣ UI REBUILD
   ├─ BlocBuilder rebuilds on state change
   ├─ Displays products in GridView
   ├─ Shows error message if failed
   └─ Shows loading spinner if loading

✅ User sees updated UI
```

---

## 🎓 التدرج الهرمي للمسؤوليات

```
┌─────────────────────────────────────────────────────┐
│                   CORE LAYER                        │
│            (Shared by all layers)                   │
│  - Constants, Errors, Utils, Logger                │
└─────────────────────────────────────────────────────┘
              △           △           △
              │           │           │
┌─────────────┴───┐   ┌───┴─────────┬─────────────┐
│                 │   │             │             │
PRESENTATION   DOMAIN          DATA
LAYER          LAYER          LAYER
│                 │   │             │             │
├─ Pages         ├─ Entities      ├─ Models
├─ Widgets       ├─ Repositories  ├─ Repositories
├─ BLoC          ├─ UseCases      ├─ DataSources
│                │    (Abstract)   │
└─────────────────┴───┴─────────────┴─────────────┘

القاعدة الذهبية:
- الطبقات العليا تعتمد على الطبقات السفلية فقط
- لا تعتمد الطبقات السفلية على العليا
- Domain و Data لا تعتمد على أي Framework

Lower Layers يجب أن تكون:
✅ مستقلة
✅ مختبرة
✅ قابلة لإعادة الاستخدام
✅ بطيئة التغيير
```

---

## 🔌 نقاط الدخول (Entry Points)

```
main.dart
   │
   ├─ setupServiceLocator()        # إعداد DI
   │
   ├─ BlocProvider<SkinProductBloc>()  # توفير BLoC
   │
   └─ MaterialApp(
        onGenerateRoute: AppRoutes.generateRoute
                       └─ يفتح الصفحات المختلفة
        )
```

---

## 📋 نموذج Dependency Injection

```
Service Locator (GetIt)
│
├─ Data Sources
│   ├─ SkinRemoteDataSource
│   └─ SkinLocalDataSource
│
├─ Repositories
│   └─ SkinProductRepository
│
├─ Use Cases
│   ├─ GetAllProductsUseCase
│   ├─ GetProductByIdUseCase
│   └─ SearchProductsUseCase
│
├─ BLoCs
│   └─ SkinProductBloc
│
└─ Controllers (if needed)
```

---

## 🎯 مراحل التطوير

```
Phase 1: Setup ✅
├─ Create folder structure
├─ Add dependencies
└─ Create base classes

Phase 2: Core ✅
├─ Constants
├─ Errors/Failures
└─ Utils

Phase 3: Domain ✅
├─ Entities
├─ Repositories (Abstract)
└─ Use Cases

Phase 4: Data ✅
├─ Models
├─ Data Sources
└─ Repository Implementation

Phase 5: Presentation ✅
├─ BLoC (Events, States, Logic)
├─ Widgets
└─ Pages

Phase 6: Integration 🟡 (TODO)
├─ Service Locator Setup
├─ Route Configuration
└─ Connect all layers

Phase 7: Testing 🟡 (TODO)
├─ Unit tests (Domain)
├─ Widget tests (UI)
└─ Integration tests

Phase 8: Production 🔴 (Future)
├─ Error handling
├─ Logging
└─ Performance optimization
```

---

## 💡 نمط الاتصال بين الطبقات

```
Presentation → Domain → Data → External

✅ المسموح:
- Presentation استدعاء Domain Use Cases
- Domain استدعاء Repository Interface
- Data استدعاء API/Database
- Data return Models, Domain يحولها لـ Entities

❌ الممنوع:
- Presentation استدعاء Data مباشرة
- Domain import من Presentation
- Data import من Presentation
- استخدام Framework classes في Domain


```

---

## 🎊 الخلاصة

هذا الهيكل يوفر:

```
✨ قابلية الاختبار (Testability)
  - كل طبقة تُختبر بشكل مستقل
  - استخدام Mocks والـ Stubs

✨ قابلية الصيانة (Maintainability)
  - كود منظم وواضح
  - سهل البحث والتعديل

✨ قابلية التوسع (Scalability)
  - أضف features بسهولة
  - تغيير التفاصيل بدون تأثر

✨ إعادة الاستخدام (Reusability)
  - نفس Domain في تطبيقات أخرى
  - نفس Repository في سياقات مختلفة
```

---

**هذا الهيكل = نظام قوي وآمن! 🚀**
