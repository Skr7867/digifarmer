import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/chooseRole/choose_role_model.dart';
import 'choose_role_repository.dart';

class ChooseRoleHttpRepository implements ChooseRoleRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<ChooseRoleModel> chooseRoleApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.chooseRoleApi);
    return ChooseRoleModel.fromJson(response);
  }
}
