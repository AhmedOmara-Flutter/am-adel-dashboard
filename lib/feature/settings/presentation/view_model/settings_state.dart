part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final RestaurantStatusEntity restaurantStatus;

  SettingsLoaded({
    required this.restaurantStatus,
  });
}

final class SettingsUpdating extends SettingsState {
  final RestaurantStatusEntity restaurantStatus;

  SettingsUpdating({
    required this.restaurantStatus,
  });
}

final class SettingsError extends SettingsState {
  final String message;

  SettingsError({
    required this.message,
  });
}