import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/app/data/repository/user_repository.dart';
import 'package:finful_app/app/domain/interactor/user_interactor.dart';
import 'package:finful_app/app/domain/model/user_ext_model.dart';

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

  @override
  Future<UserExtModel> getCurrentUserExtraInfo() async {
    final response = await _userRepository.getCurrentUserExtraInfo();
    final planResponse = response.plan;
    final plan = planResponse != null ? UserPlanModel(
      time: planResponse.time,
      type: planResponse.type,
      location: planResponse.location,
    ) : null;
    final model = UserExtModel(
      plan: plan,
      housePrice: response.housePrice,
      loanAmount: response.loanAmount,
      amountSaved: response.amountSaved,
    );
    return model;
  }

  @override
  Future<bool> submitDeleteAccount() async {
    final response = await _userRepository.deleteAccount();
    final isSuccess = response.success ?? false;
    return isSuccess;
  }
}