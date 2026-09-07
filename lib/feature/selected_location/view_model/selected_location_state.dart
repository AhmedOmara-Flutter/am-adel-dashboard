part of 'selected_location_cubit.dart';

@immutable
sealed class SelectedLocationState {}

final class SelectedLocationInitial extends SelectedLocationState {}

final class SelectedLocationGetLoading extends SelectedLocationState {}

final class SelectedLocationGetSuccess extends SelectedLocationState {
final List<SelectedLocationEntity> locations;

SelectedLocationGetSuccess({
required this.locations,
});
}

final class SelectedLocationGetError extends SelectedLocationState {
final String message;

SelectedLocationGetError({
required this.message,
});
}

final class SelectedLocationAddLoading extends SelectedLocationState {}

final class SelectedLocationAddSuccess extends SelectedLocationState {}

final class SelectedLocationAddError extends SelectedLocationState {
final String message;

SelectedLocationAddError({
required this.message,
});
}

final class SelectedLocationUpdateLoading extends SelectedLocationState {}

final class SelectedLocationUpdateSuccess extends SelectedLocationState {}

final class SelectedLocationUpdateError extends SelectedLocationState {
final String message;

SelectedLocationUpdateError({
required this.message,
});
}

final class SelectedLocationDeleteLoading extends SelectedLocationState {}

final class SelectedLocationDeleteSuccess extends SelectedLocationState {}

final class SelectedLocationDeleteError extends SelectedLocationState {
final String message;

SelectedLocationDeleteError({
required this.message,
});
}
