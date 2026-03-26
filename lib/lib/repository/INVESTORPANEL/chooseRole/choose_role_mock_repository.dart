import '../../../model/INVESTORPANEL/chooseRole/choose_role_model.dart';
import 'choose_role_repository.dart';

class ChooseRoleMockRepository implements ChooseRoleRepository {
  @override
  Future<ChooseRoleModel> chooseRoleApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return ChooseRoleModel.fromJson(response);
  }
}
