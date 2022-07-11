import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants/app_assets.dart';
import 'constants/app_colors.dart';
import 'generated/l10n.dart';
import 'persons_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final List<Widget> _pageOptions = <Widget>[
    const PersonsScreen(title: ''),
    const SettingsScreen(title: '')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.svg.persons,
              width: 20.0,
              color: AppColors.neutral2,
            ),
            label: S.of(context).persons,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.svg.settings,
              width: 20.0,
              color: AppColors.neutral2,
            ),
            label: S.of(context).settings,
          ),
        ],
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
      ),
    );
  }
}
