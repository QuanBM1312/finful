
import 'package:finful_app/app/data/repository/auth_repository.dart';
import 'package:finful_app/app/data/repository/user_repository.dart';
import 'package:finful_app/app/domain/interactor/session_interactor.dart';
import 'package:finful_app/app/injection/injection.dart';
import 'package:finful_app/core/datasource/config.dart';

class SessionInteractorImpl implements SessionInteractor {
  late final UserRepository _userRepository;
  late final AuthRepository _authRepository;

  SessionInteractorImpl({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository;

  @override
  Future<void> clearSessionDataAtLocal() async {
    Injection().authorization = null;
    await _authRepository.clearAuthorizationAtLocal();
    await _userRepository.clearUserAtLocal();
  }

  @override
  Authorization? getLoggedInAuthorization() {
    return _authRepository.getAuthorizationFromLocal();
  }
}