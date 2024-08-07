import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(const BannerInitial(currentPage: 0)) {
    on<BannerNextEvent>((event, emit) {
      final int nextPage = (state.currentPage + 1) % 3; 
      emit(BannerInitial(currentPage: nextPage));
    });
    on<BannerPageChangedEvent>((event, emit) {
      emit(BannerInitial(currentPage: event.pageIndex));
    });
  }
}
