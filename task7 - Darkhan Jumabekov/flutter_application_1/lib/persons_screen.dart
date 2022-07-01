import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/repo_persons.dart';
import 'package:flutter_application_1/search_field.dart';
import 'package:intl/intl.dart';
import 'generated/l10n.dart';
import 'constants/app_assets.dart';
import 'constants/app_colors.dart';
import 'constants/app_styles.dart';
import 'package:flutter_application_1/vmodel.dart';
import 'package:provider/provider.dart';

class PersonsScreen extends StatelessWidget {
  const PersonsScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  Widget listView(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: context
                          .watch<PersonsListVModel>()
                          .filteredList[index]
                          .image ==
                      null
                  ? AssetImage(AppAssets.images.noAvatar) as ImageProvider
                  : NetworkImage(context
                      .watch<PersonsListVModel>()
                      .filteredList[index]
                      .image!),
              radius: 36,
            ),
            const SizedBox(width: 16), //отступ
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context
                                    .watch<PersonsListVModel>()
                                    .filteredList[index]
                                    .status ==
                                "Dead" ||
                            context
                                    .watch<PersonsListVModel>()
                                    .filteredList[index]
                                    .status ==
                                "Мертв"
                        ? S.of(context).dead.toUpperCase()
                        : S.of(context).alive.toUpperCase(),
                    style: AppStyles.s10w500.copyWith(
                        color: context
                                        .watch<PersonsListVModel>()
                                        .filteredList[index]
                                        .status ==
                                    "Dead" ||
                                context
                                        .watch<PersonsListVModel>()
                                        .filteredList[index]
                                        .status ==
                                    "Мертв"
                            ? Colors.red
                            : Colors.green),
                  ),
                  Text(
                    context
                        .watch<PersonsListVModel>()
                        .filteredList[index]
                        .name
                        .toString(),
                    style:
                        AppStyles.s12w700.copyWith(color: AppColors.mainText),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  Widget gridView(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: context
                          .watch<PersonsListVModel>()
                          .filteredList[index]
                          .image ==
                      null
                  ? AssetImage(AppAssets.images.noAvatar) as ImageProvider
                  : NetworkImage(context
                      .watch<PersonsListVModel>()
                      .filteredList[index]
                      .image!),
              radius: 36,
            ),
            const SizedBox(height: 16), //отступ
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  context
                                  .watch<PersonsListVModel>()
                                  .filteredList[index]
                                  .status ==
                              "Dead" ||
                          context
                                  .watch<PersonsListVModel>()
                                  .filteredList[index]
                                  .status ==
                              "Мертв"
                      ? S.of(context).dead.toUpperCase()
                      : S.of(context).alive.toUpperCase(),
                  style: AppStyles.s10w500.copyWith(
                      color: context
                                      .watch<PersonsListVModel>()
                                      .filteredList[index]
                                      .status ==
                                  "Dead" ||
                              context
                                      .watch<PersonsListVModel>()
                                      .filteredList[index]
                                      .status ==
                                  "Мертв"
                          ? Colors.red
                          : Colors.green),
                ),
                Text(
                    context
                        .watch<PersonsListVModel>()
                        .filteredList[index]
                        .name
                        .toString(),
                    style:
                        AppStyles.s12w700.copyWith(color: AppColors.mainText)),
                Text(
                    "${context.watch<PersonsListVModel>().filteredList[index].species == 'Human' ? S.of(context).species : S.of(context).species}, "
                    "${context.watch<PersonsListVModel>().filteredList[index].gender == 'Men' ? S.of(context).men : S.of(context).women}",
                    style:
                        AppStyles.s10w500.copyWith(color: AppColors.neutral2)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => PersonsListVModel(
            repo: Provider.of<RepoPersons>(context, listen: false),
          ),
          builder: (context, _) {
            final personsTotal =
                context.watch<PersonsListVModel>().filteredList.length;
            return Column(
              children: [
                SearchField(
                  onChanged: (value) {
                    Provider.of<PersonsListVModel>(context, listen: false)
                        .filter(
                      value.toLowerCase(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${S.of(context).personsCount}: $personsTotal"
                              .toUpperCase(),
                          style: AppStyles.s10w500.copyWith(
                            letterSpacing: 1.5,
                            color: AppColors.neutral2,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(context.watch<PersonsListVModel>().isListView
                            ? Icons.grid_view
                            : Icons.list),
                        iconSize: 28.0,
                        color: AppColors.neutral2,
                        onPressed: () {
                          Provider.of<PersonsListVModel>(context, listen: false)
                              .switchView();
                        },
                      ),
                    ],
                  ),
                ),
                Consumer<PersonsListVModel>(
                  builder: (context, vmodel, _) {
                    if (vmodel.isLoading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                    if (vmodel.errorMessage != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(vmodel.errorMessage!),
                          ),
                        ],
                      );
                    }

                    if (vmodel.filteredList.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(S.of(context).personsListIsEmpty),
                          )
                        ],
                      );
                    }
                    return Expanded(
                      child: vmodel.isListView
                          ? ListView.builder(
                              itemCount: vmodel.filteredList.length,
                              itemBuilder: (vmodel, index) =>
                                  listView(vmodel, index),
                            )
                          : GridView.builder(
                              itemCount: vmodel.filteredList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2.0,
                                      mainAxisSpacing: 2.0),
                              itemBuilder: (vmodel, index) =>
                                  gridView(vmodel, index),
                            ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
