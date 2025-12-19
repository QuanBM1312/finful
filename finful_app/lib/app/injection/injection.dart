
import 'package:finful_app/app/data/datasource/local/auth_local_datasource.dart';
import 'package:finful_app/app/data/datasource/local/impl/auth_local_datasoure_impl.dart';
import 'package:finful_app/app/data/datasource/local/impl/user_local_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/local/user_local_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/auth_remote_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/expert_remote_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/impl/auth_remote_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/remote/impl/expert_remote_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/remote/impl/plan_remote_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/remote/impl/section_remote_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/remote/impl/user_remote_datasource_impl.dart';
import 'package:finful_app/app/data/datasource/remote/plan_remote_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/section_remote_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/user_remote_datasource.dart';
import 'package:finful_app/app/data/repository/auth_repository.dart';
import 'package:finful_app/app/data/repository/expert_repository.dart';
import 'package:finful_app/app/data/repository/plan_repository.dart';
import 'package:finful_app/app/data/repository/section_repository.dart';
import 'package:finful_app/app/data/repository/user_repository.dart';
import 'package:finful_app/app/domain/interactor/auth_interactor.dart';
import 'package:finful_app/app/domain/interactor/expert_interactor.dart';
import 'package:finful_app/app/domain/interactor/impl/auth_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/impl/expert_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/impl/plan_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/impl/section_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/impl/session_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/impl/user_interactor_impl.dart';
import 'package:finful_app/app/domain/interactor/plan_interactor.dart';
import 'package:finful_app/app/domain/interactor/section_interactor.dart';
import 'package:finful_app/app/domain/interactor/session_interactor.dart';
import 'package:finful_app/app/domain/interactor/user_interactor.dart';
import 'package:finful_app/app/domain/repository_impl/auth_repository_impl.dart';
import 'package:finful_app/app/domain/repository_impl/expert_repository_impl.dart';
import 'package:finful_app/app/domain/repository_impl/plan_repository_impl.dart';
import 'package:finful_app/app/domain/repository_impl/section_repository_impl.dart';
import 'package:finful_app/app/domain/repository_impl/user_repository_impl.dart';
import 'package:finful_app/app/presentation/blocs/constructors.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:finful_app/core/datasource/config.dart';
import 'package:finful_app/core/extension/extension.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Injection {
  static final Injection _singleton = Injection._internal();

  factory Injection() {
    return _singleton;
  }

  Injection._internal();

  late SharedPreferences _sharedPreferences;

  Authorization? authorization;

  bool get isAuthorized =>
      authorization != null && authorization!.accessToken.isNotNullAndEmpty;

  GetIt get getIt => _getIt;

  late GetIt _getIt;

  /// will get from environment
  String get getHost => 'https://muanha.finful.co/api';

  /// will get from environment
  String get getMediaHost => 'https://muanha.finful.co/api/image?url';

  /// will get from environment
  HeaderConfig get getHeaderConfig => HeaderConfig(
      encodedCredentials: 'xxx',
      refreshTokenPath: '$getHost/auth/agent/refresh-token');

  Future<void> initialize() async {
    _getIt = GetIt.instance;
    _sharedPreferences = await SharedPreferences.getInstance();
    BlocManager().initialize(blocConstructors);

    // ================    remote data source    ================
    _getIt.registerSingleton<AuthRemoteDatasource>(
      AuthRemoteDatasourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );

    _getIt.registerSingleton<UserRemoteDatasource>(
      UserRemoteDatasourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );

    _getIt.registerSingleton<SectionRemoteDatasource>(
      SectionRemoteDatasourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );

    _getIt.registerSingleton<PlanRemoteDatasource>(
      PlanRemoteDatasourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );

    _getIt.registerSingleton<ExpertRemoteDatasource>(
      ExpertRemoteDatasourceImpl(
        host: getHost,
        config: getHeaderConfig,
        getAuthorization: () => authorization,
      ),
    );
    // ================    remote data source    ================

    // ================    local data source    ================
    _getIt.registerSingleton<AuthLocalDatasource>(
      AuthLocalDatasourceImpl(
        preferences: _sharedPreferences,
      ),
    );

    _getIt.registerSingleton<UserLocalDatasource>(
      UserLocalDatasourceImpl(
        preferences: _sharedPreferences,
      ),
    );
    // ================  local data source  ================

    // ================    repository    ================
    _getIt.registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
        authLocalDatasource: _getIt<AuthLocalDatasource>(),
        authRemoteDatasource: _getIt<AuthRemoteDatasource>(),
      ),
    );

    _getIt.registerFactory<UserRepository>(
          () => UserRepositoryImpl(
        userLocalDatasource: _getIt<UserLocalDatasource>(),
        userRemoteDatasource: _getIt<UserRemoteDatasource>(),
      ),
    );

    _getIt.registerFactory<SectionRepository>(
          () => SectionRepositoryImpl(
        sectionRemoteDatasource: _getIt<SectionRemoteDatasource>(),
      ),
    );

    _getIt.registerFactory<PlanRepository>(
          () => PlanRepositoryImpl(
        planRemoteDatasource: _getIt<PlanRemoteDatasource>(),
      ),
    );

    _getIt.registerFactory<ExpertRepository>(
          () => ExpertRepositoryImpl(
        expertRemoteDatasource: _getIt<ExpertRemoteDatasource>(),
      ),
    );
    // ================    repository    ================

    // ================    interactor    ================
    _getIt.registerFactory<AuthInteractor>(
          () => AuthInteractorImpl(
        authRepository: _getIt<AuthRepository>(),
        userRepository: _getIt<UserRepository>(),
      ),
    );

    _getIt.registerFactory<UserInteractor>(
          () => UserInteractorImpl(
        userRepository: _getIt<UserRepository>(),
      ),
    );

    _getIt.registerFactory<SessionInteractor>(
          () => SessionInteractorImpl(
        userRepository: _getIt<UserRepository>(),
        authRepository: _getIt<AuthRepository>(),
      ),
    );

    _getIt.registerFactory<SectionInteractor>(
          () => SectionInteractorImpl(
        sectionRepository: _getIt<SectionRepository>(),
      ),
    );

    _getIt.registerFactory<PlanInteractor>(
          () => PlanInteractorImpl(
        planRepository: _getIt<PlanRepository>(),
      ),
    );

    _getIt.registerFactory<ExpertInteractor>(
          () => ExpertInteractorImpl(
        expertRepository: _getIt<ExpertRepository>(),
      ),
    );
    // ================    interactor    ================
  }
}