import 'package:digifarmer/repository/personalInfo/personal_info_repository.dart';
import '../../model/personalInfo/personal_details_response_model.dart';

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
