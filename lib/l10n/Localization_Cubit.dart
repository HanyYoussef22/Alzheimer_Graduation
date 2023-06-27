import 'package:hydrated_bloc/hydrated_bloc.dart';
class LanguageCubit extends HydratedCubit<String>
{
  LanguageCubit() : super('en'); // Default language code is 'en' (English)

  void toggleLanguage({required String languageCode}) {
    emit(languageCode);
  }
  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['languageCode'] as String?;
  }

  @override
  Map<String, dynamic>? toJson(String state) {
    return {
      'languageCode': state,
    };
  }
}