// Example Implementation Guide - دليل التطبيق العملي

/*
==============================================================================
مثال عملي كامل لتطبيق Clean Architecture
==============================================================================

اتبع الخطوات التالية لتطبيق النمط بشكل صحيح:

1. START: User Clicks Button (عرض التطبيق)
2. BLoC: Emit Event
3. Use Case: Execute Business Logic
4. Repository: Handle Data Flow
5. Data Source: Fetch Data (API/Cache)
6. END: UI Updates with new State


==============================================================================
STEP 1: إنشاء Entity (كائن المجال - مستقل عن الإطار)
==============================================================================
*/

// lib/domain/entities/user.dart
/*
class User {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });
}
*/

/*
==============================================================================
STEP 2: إنشاء Model (نموذج البيانات - مع JSON Serialization)
==============================================================================
*/

// lib/data/models/user_model.dart
/*
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  User toEntity() {
    return User(id: id, name: name, email: email);
  }
}
*/

/*
==============================================================================
STEP 3: إنشاء Repository Interface (واجهة المستودع - في Domain)
==============================================================================
*/

// lib/domain/repositories/user_repository.dart
/*
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getAllUsers();
}
*/

/*
==============================================================================
STEP 4: إنشاء Repository Implementation (تطبيق المستودع - في Data)
==============================================================================
*/

// lib/data/repositories/user_repository_impl.dart
/*
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      // حاول الحصول من API
      final users = await remoteDataSource.getAllUsers();
      // احفظ في الذاكرة المحلية
      await localDataSource.cacheUsers(users);
      // تحويل Models إلى Entities
      return Right(users.map((m) => m.toEntity()).toList());
    } catch (e) {
      // إذا فشل API، حاول من الذاكرة المحلية
      try {
        final cachedUsers = await localDataSource.getCachedUsers();
        return Right(cachedUsers.map((m) => m.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure('Error: $e'));
      }
    }
  }
}
*/

/*
==============================================================================
STEP 5: إنشاء Use Case (حالة الاستخدام - منطق الأعمال)
==============================================================================
*/

// lib/domain/usecases/get_all_users_usecase.dart
/*
class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  // يمكن استدعاء الـ Use Case مباشرة
  Future<Either<Failure, List<User>>> call() async {
    return await repository.getAllUsers();
  }
}
*/

/*
==============================================================================
STEP 6: إنشاء BLoC Events و States
==============================================================================
*/

// lib/presentation/bloc/user_event.dart
/*
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetAllUsersEvent extends UserEvent {
  const GetAllUsersEvent();

  @override
  List<Object> get props => [];
}
*/

// lib/presentation/bloc/user_state.dart
/*
abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
*/

/*
==============================================================================
STEP 7: إنشاء BLoC
==============================================================================
*/

// lib/presentation/bloc/user_bloc.dart
/*
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;

  UserBloc({required this.getAllUsersUseCase})
      : super(const UserInitial()) {
    on<GetAllUsersEvent>(_onGetAllUsers);
  }

  Future<void> _onGetAllUsers(
    GetAllUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getAllUsersUseCase();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (users) => emit(UserLoaded(users)),
    );
  }
}
*/

/*
==============================================================================
STEP 8: استخدام BLoC في الـ UI
==============================================================================
*/

// lib/presentation/pages/users_page.dart
/*
class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              // تحميل البيانات عند فتح الصفحة
              context.read<UserBloc>().add(const GetAllUsersEvent());
              return const SizedBox();
            }

            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              );
            }

            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // إعادة تحميل البيانات
          context.read<UserBloc>().add(const GetAllUsersEvent());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
*/

/*
==============================================================================
STEP 9: إعداد Dependency Injection
==============================================================================
*/

// lib/config/service_locator.dart
/*
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register Data Sources
  getIt.registerSingleton<UserLocalDataSource>(
    UserLocalDataSourceImpl(),
  );

  getIt.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSourceImpl(client: http.Client()),
  );

  // Register Repositories
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Register Use Cases
  getIt.registerSingleton<GetAllUsersUseCase>(
    GetAllUsersUseCase(getIt()),
  );

  // Register BLoC
  getIt.registerSingleton<UserBloc>(
    UserBloc(getAllUsersUseCase: getIt()),
  );
}
*/

// في main.dart
/*
void main() {
  setupServiceLocator(); // تفعيل Dependency Injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
      child: MaterialApp(
        home: const UsersPage(),
      ),
    );
  }
}
*/

/*
==============================================================================
STEP 10: Data Flow الكامل
==============================================================================

1. USER INTERACTION (في UI):
   - المستخدم يضغط على زر
   - context.read<UserBloc>().add(GetAllUsersEvent());

2. BLoC EVENT HANDLING:
   - BLoC يستقبل GetAllUsersEvent
   - ينادي _onGetAllUsers
   - ينبث UserLoading state

3. USE CASE EXECUTION:
   - Use Case ينادي repository.getAllUsers()

4. REPOSITORY LOGIC:
   - يحاول جلب من Remote DataSource
   - إذا نجح، يحفظ في Local DataSource
   - تحويل Models إلى Entities

5. DATA SOURCE:
   - Remote: استدعاء API
   - Local: قراءة من Cached/Database

6. STATE EMISSION:
   - إذا نجح: emit UserLoaded
   - إذا فشل: emit UserError

7. UI REBUILD:
   - BlocBuilder يعيد بناء الـ UI
   - يعرض البيانات أو الخطأ

==============================================================================
*/

// ❌ ماذا تتجنب:

// ❌ لا تتجاوز الطبقات:
// presentation ← → data  (خطأ!)
// يجب أن يكون:
// presentation → domain ← data

// ❌ لا تستخدم Framework classes في Domain:
// class User {
//   BuildContext context; // ❌ خطأ!
// }

// ❌ لا تخلط بين Entities و Models في Presentation:
// widget(entity); // ✅ صحيح
// widget(model);  // ❌ خطأ!

// ✅ أفضل الممارسات:

// ✅ استخدم Either للتعامل مع الأخطاء:
// Future<Either<Failure, Data>> getData() async { }

// ✅ حافظ على الطبقات مستقلة:
// يمكن تغيير Database بدون تأثر Presentation

// ✅ اختبر كل طبقة بشكل منفصل:
// test('should return data') async { }

// ✅ تم الانتهاء من النمط بنجاح!
