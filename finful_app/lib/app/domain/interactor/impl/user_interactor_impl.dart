
import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/app/data/repository/user_repository.dart';
import 'package:finful_app/app/domain/interactor/user_interactor.dart';

class UserInteractorImpl implements UserInteractor {
  late final UserRepository _userRepository;

  UserInteractorImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  User? getLoggedInUserFromLocal() {
    return _userRepository.getLoggedInUserFromLocal();
  }

  @override
  Future<void> saveLoggedInUserToLocal(User currentUser) async {
    await _userRepository.saveUserToLocal(user: currentUser);
  }

  @override
  Future<User?> getLoggedInUser({
    required bool forceToUpdate,
    required String? userId
  }) async {
    final loggedInUser = await _userRepository.getLoggedInUser(
      forceToUpdate: forceToUpdate,
      userId: userId,
    );
    return loggedInUser;
  }
}