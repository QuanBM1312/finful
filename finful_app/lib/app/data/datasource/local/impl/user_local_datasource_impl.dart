
import 'package:finful_app/app/data/datasource/local/user_local_datasource.dart';
import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/core/datasource/base_local.dart';
import 'package:finful_app/core/entity/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _currentUserKey = 'key_current_user';

class UserLocalDatasourceImpl extends BaseLocal<User>
    implements UserLocalDatasource {
  UserLocalDatasourceImpl({
    required SharedPreferences preferences,
  }) : super(
    mapper: Mapper<User>(parse: User.fromJson),
    prefs: preferences,
  );

  @override
  User? loadUser() {
    return getItem(_currentUserKey);
  }

  @override
  Future<void> saveUser(User user) async {
    await clearObjectOrEntity(_currentUserKey);
    await saveItem(user, _currentUserKey);
  }

  @override
  Future<void> clearUser() async {
    await clearObjectOrEntity(_currentUserKey);
  }
}
