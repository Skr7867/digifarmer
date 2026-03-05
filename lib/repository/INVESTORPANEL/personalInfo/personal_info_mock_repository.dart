import '../../../model/INVESTORPANEL/personalInfo/personal_details_response_model.dart';
import 'personal_info_repository.dart';

class PersonalInfoMockRepository implements PersonalInfoRepository {
  @override
  Future<PersonalDetailsResponseModel> personalInfoApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return PersonalDetailsResponseModel.fromJson(response);
  }
}
