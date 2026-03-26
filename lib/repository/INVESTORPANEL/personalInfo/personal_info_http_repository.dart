import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';

import '../../../model/INVESTORPANEL/personalInfo/personal_details_response_model.dart';
import 'personal_info_repository.dart';

class PersonalInfoHttpRepository implements PersonalInfoRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<PersonalDetailsResponseModel> personalInfoApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.personalInfoApi);
    return PersonalDetailsResponseModel.fromJson(response);
  }
}
