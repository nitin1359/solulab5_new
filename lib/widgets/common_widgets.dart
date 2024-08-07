import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1D1D1D),
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF0C8A7B)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget customSwitzerText({
  required String text,
  required double fontSize,
  required FontWeight fontWeight,
  Color? color,
  int maxLines = 2,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: TextStyle(
      fontFamily: 'Switzer',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget customTextFormField({
  required String labelText,
  String? hintText,
  bool obscureText = false,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101817),
          ),
        ),
      ),
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF828A89),
            fontFamily: 'Switzer',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Widget customButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0C8A7B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontFamily: 'Switzer'),
        ),
      ),
    ),
  );
}

Widget customButtonwithImage({
  required String text,
  required VoidCallback onPressed,
  required String imagePath,
}) {
  return Expanded(
    child: SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0C8A7B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'Switzer'),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget customGoogleButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: SizedBox(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/google.png', height: 24, width: 24),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF101817),
                    fontFamily: 'Switzer',
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    ),
  );
}

Widget customBackButton({required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/svg/back_arrow.svg',
          height: 24,
          width: 24,
        ),
      ),
    ),
  );
}

Widget customDeleteButton({required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/svg/delete_button.svg',
          height: 24,
          width: 24,
        ),
      ),
    ),
  );
}

Widget customFavouriteButton({required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/svg/favourite.svg',
          height: 24,
          width: 24,
        ),
      ),
    ),
  );
}

Widget customNotificationButton({required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/svg/notification_bell.svg',
          height: 24,
          width: 24,
        ),
      ),
    ),
  );
}

Widget bannerSection() {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  return SizedBox(
    height: 130,
    child: Stack(
      children: [
        PageView.builder(
          itemCount: 3,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            currentPage = index;
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SvgPicture.asset(
                    'assets/images/svg/special_offers${index + 1}.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 6.0,
                  width: index == currentPage ? 10.0 : 6.0,
                  decoration: BoxDecoration(
                    color: index == currentPage
                        ? const Color(0xFF0C8A7B)
                        : const Color(0xFF98B7B3),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget categoryButton({
  required int index,
  required String svgAsset,
  required String text,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 12.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: index == 0 ? Colors.teal : Colors.white,
        foregroundColor: index == 0 ? Colors.white : const Color(0xFF828A89),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            SvgPicture.asset(
              svgAsset,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                index == 0 ? Colors.white : const Color(0xFF828A89),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13.0,
                fontFamily: 'Switzer',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
