part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class OnChangePageEvent extends NavigationEvent {
  final Widget selectedPage;
  const OnChangePageEvent({
    required this.selectedPage,
  });
}
