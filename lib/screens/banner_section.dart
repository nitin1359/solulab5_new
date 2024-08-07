import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/blocs/banner_bloc/banner_bloc.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  BannerSectionState createState() => BannerSectionState();
}

class BannerSectionState extends State<BannerSection> {
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        final int nextPage = (_pageController.page!.toInt() + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        context.read<BannerBloc>().add(BannerNextEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients && _pageController.page!.toInt() != state.currentPage) {
            _pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });

        return SizedBox(
          height: 145,
          child: Column(
            children: [
              SizedBox(
                height: 130,
                child: PageView.builder(
                  itemCount: 3,
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    context.read<BannerBloc>().add(BannerPageChangedEvent(index));
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/special_offer${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      color: index == state.currentPage
                          ? const Color(0xFF0C8A7B)
                          : const Color(0xFF98B7B3),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
