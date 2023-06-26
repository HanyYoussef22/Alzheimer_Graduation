import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<bool>
{
  ThemeCubit():super(true);

  // bool? State;

  void toggleTheme({required bool value})
  {
    // State=value;
    emit(value);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json["isDark"];
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return{
      "isDark":state
    };
  }
  

}