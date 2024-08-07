part of 'banner_bloc.dart';

class BannerState extends Equatable {
  final int currentPage;

  const BannerState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class BannerInitial extends BannerState {
  const BannerInitial({required super.currentPage});
}