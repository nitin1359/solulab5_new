import 'package:flutter/material.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 87.0),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildOnboardingPage(
                    'assets/images/onboarding1.png',
                    'View And Experience\nFurniture With The Help\nOf Augmented Reality',
                  ),
                  _buildOnboardingPage(
                    'assets/images/onboarding2.png',
                    'Design Your Space With\nAugmented Reality By\nCreating Room',
                  ),
                  _buildOnboardingPage(
                    'assets/images/onboarding3.png',
                    'Explore World Class Top\nFurnitures As Per Your\nRequirements & Choice',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 2)
                    TextButton(
                      onPressed: () {
                        _navigateToSignInScreen();
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF828A89),
                          fontFamily: 'Switzer',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  _currentPage == 2
                      ? customButton(
                          text: 'Get Started',
                          onPressed: () {
                            _navigateToSignInScreen();
                          },
                        )
                      : SizedBox(
                          height: 56,
                          width: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: const Color(0xFF0C8A7B),
                              padding: const EdgeInsets.all(0),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(String imagePath, String title) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(181.75),
          child: Image.asset(
            imagePath,
            height: 375,
            width: 375,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Switzer',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      height: 6.0,
      width: isActive ? 6.0 : 6.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0C8A7B) : const Color(0xFF98B7B3),
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }

  void _navigateToSignInScreen() {
    Navigator.pushReplacementNamed(context, '/signin');
  }
}
