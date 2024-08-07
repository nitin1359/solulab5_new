part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class BannerNextEvent extends BannerEvent {}

class BannerPageChangedEvent extends BannerEvent {
  final int pageIndex;

  const BannerPageChangedEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}