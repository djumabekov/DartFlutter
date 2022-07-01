import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/repo_settings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'constants/app_styles.dart';
import 'generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: AppStyles.s16w500,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: AppColors.mainText,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${S.of(context).language}: '),
                    DropdownButton<String>(
                      value: Intl.getCurrentLocale(),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            S.of(context).english,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ru_RU',
                          child: Text(
                            S.of(context).russian,
                          ),
                        ),
                      ],
                      onChanged: (value) async {
                        if (value == null) return;
                        if (value == 'ru_RU') {
                          await S.load(
                            const Locale('ru', 'RU'),
                          );
                          setState(() {});
                        } else if (value == 'en') {
                          await S.load(
                            const Locale('en'),
                          );
                          setState(() {});
                        }
                        final repoSettings =
                            Provider.of<RepoSettings>(context, listen: false);
                        repoSettings.saveLocale(value);
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
