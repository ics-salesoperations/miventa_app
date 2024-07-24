import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:miventa_app/pages/pages.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedPage: InicioPage())) {
    on<OnChangePageEvent>(
      (event, emit) => emit(
        state.copyWith(
          selectedPage: event.selectedPage,
        ),
      ),
    );
  }

  Route crearRuta({required Widget destination}) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            destination,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(curvedAnimation),
            child: child,
          );

          // return ScaleTransition(
          //     child: child,
          //     scale:
          //         Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation));

          // RotationTransition
          // return RotationTransition(
          //   child: child,
          //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation)
          // );

          // return FadeTransition(
          //   child: child,
          //   opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
          // );

          //   return RotationTransition(
          //       child: FadeTransition(
          //           child: child,
          //           opacity: Tween<double>(begin: 0.0, end: 1.0)
          //               .animate(curvedAnimation)),
          //       turns:
          //           Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation));
        });
  }
}
