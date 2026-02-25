import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_theme.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String themeKey = "isDarkTheme";

  ThemeBloc()
    : super(ThemeState(themeData: AppThemes.lightTheme, isDark: false)) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  Future<void> _loadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(themeKey) ?? false;

    emit(
      ThemeState(
        themeData: isDark ? AppThemes.darkTheme : AppThemes.lightTheme,
        isDark: isDark,
      ),
    );
  }

  Future<void> _toggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.isDark;

    await prefs.setBool(themeKey, newValue);

    emit(
      ThemeState(
        themeData: newValue ? AppThemes.darkTheme : AppThemes.lightTheme,
        isDark: newValue,
      ),
    );
  }
}
