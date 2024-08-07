import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationHome()) {
    on<NavigationEvent>((event, emit) {
      switch (event) {
        case NavigationEvent.home:
          emit(NavigationHome());
          break;
        case NavigationEvent.favorite:
          emit(NavigationFavorite());
          break;
        case NavigationEvent.cart:
          emit(NavigationCart());
          break;
        case NavigationEvent.profile:
          emit(NavigationProfile());
          break;
      }
    });
  }
}