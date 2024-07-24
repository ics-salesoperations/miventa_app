part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final Widget selectedPage;

  const NavigationState({
    required this.selectedPage,
  });

  NavigationState copyWith({
    Widget? selectedPage,
  }) =>
      NavigationState(
        selectedPage: selectedPage ?? this.selectedPage,
      );

  @override
  List<Object> get props => [
        selectedPage,
      ];
}
