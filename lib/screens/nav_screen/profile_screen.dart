import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solulab5/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:solulab5/widgets/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customBackButton(
                      onPressed: () {
                        context
                            .read<NavigationBloc>()
                            .add(NavigationEvent.home);
                      },
                    ),
                    Center(
                      child: customSwitzerText(
                        text: 'Profile',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF101817),
                      ),
                    ),
                    const SizedBox(width: 48.0),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.asset('assets/images/profile_image_main.png'),
                ),
                const SizedBox(height: 16.0),
                customSwitzerText(
                  text: 'Mansurul Hoque',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF101817),
                ),
                const SizedBox(height: 2.0),
                customSwitzerText(
                    text: 'mansurul952@gmail.com',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF828A89)),
                const SizedBox(height: 24),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/profile_icon.svg',
                  title: 'Profile',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/wallet_icon.svg',
                  title: 'Payment Methods',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/order_history_icon.svg',
                  title: 'Order History',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/delivery_address_icon.svg',
                  title: 'Delivery Address',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/support_center_icon.svg',
                  title: 'Support Center',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                _buildProfileOption(
                  svgAsset: 'assets/images/svg/legal_policy_icon.svg',
                  title: 'Legal Policy',
                  onTap: () {},
                ),
                const SizedBox(height: 70.0),
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('access_token');

                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: customSwitzerText(
                    text: 'Log Out',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEA3549),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String svgAsset,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 56,
      // color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: const Color(0xFFFFFFFF),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          svgAsset,
        ),
        title: Text(title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF101817),
            )),
        onTap: onTap,
      ),
    );
  }
}
