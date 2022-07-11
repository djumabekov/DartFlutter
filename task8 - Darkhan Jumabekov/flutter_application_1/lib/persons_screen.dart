import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/persons/bloc_persons.dart';
import 'package:flutter_application_1/person.dart';
import 'package:flutter_application_1/search_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generated/l10n.dart';
import 'constants/app_assets.dart';
import 'constants/app_colors.dart';
import 'constants/app_styles.dart';

class PersonsScreen extends StatelessWidget {
  const PersonsScreen({Key? key, required this.title}) : super(key: key);
  static final isListView = ValueNotifier(true);
  final String title;
  Widget listView(Person person) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: person.image == null
                  ? AssetImage(AppAssets.images.noAvatar) as ImageProvider
                  : NetworkImage(person.image!),
              radius: 36,
            ),
            const SizedBox(width: 16), //отступ
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    person.status == "Dead" || person.status == "Мертв"
                        ? S.current.dead.toUpperCase()
                        : S.current.alive.toUpperCase(),
                    style: AppStyles.s10w500.copyWith(
                        color:
                            person.status == "Dead" || person.status == "Мертв"
                                ? Colors.red
                                : Colors.green),
                  ),
                  Text(
                    person.name.toString(),
                    style:
                        AppStyles.s12w700.copyWith(color: AppColors.mainText),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  Widget gridView(Person person) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: person.image == null
                  ? AssetImage(AppAssets.images.noAvatar) as ImageProvider
                  : NetworkImage(person.image!),
              radius: 36,
            ),
            const SizedBox(height: 16), //отступ
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  person.status == "Dead" || person.status == "Мертв"
                      ? S.current.dead.toUpperCase()
                      : S.current.alive.toUpperCase(),
                  style: AppStyles.s10w500.copyWith(
                      color: person.status == "Dead" || person.status == "Мертв"
                          ? Colors.red
                          : Colors.green),
                ),
                Text(person.name.toString(),
                    style:
                        AppStyles.s12w700.copyWith(color: AppColors.mainText)),
                Text(
                    "${person.species == 'Human' ? S.current.species : S.current.species}, "
                    "${person.gender == 'Men' ? S.current.men : S.current.women}",
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
        body: Column(
          children: [
            SearchField(
              onChanged: (value) {
                BlocProvider.of<BlocPersons>(context).add(
                  EventPersonsFilterByName(value),
                );
              },
            ),
            BlocBuilder<BlocPersons, StateBlocPersons>(
              builder: (context, state) {
                var personsTotal = 0;
                if (state is StatePersonsData) {
                  personsTotal = state.data.length;
                }
                return Padding(
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
                        icon: Icon(
                            isListView.value ? Icons.grid_view : Icons.list),
                        iconSize: 28.0,
                        color: AppColors.neutral2,
                        onPressed: () {
                          isListView.value = !isListView.value;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<BlocPersons, StateBlocPersons>(
                builder: (context, state) {
                  if (state is StatePersonsLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  if (state is StatePersonsError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(state.error),
                        ),
                      ],
                    );
                  }

                  if (state is StatePersonsData) {
                    if (state.data.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(S.of(context).personsListIsEmpty),
                          )
                        ],
                      );
                    } else {
                      return ValueListenableBuilder<bool>(
                        valueListenable: isListView,
                        builder: (context, isListViewMode, _) {
                          return isListViewMode
                              ? ListView.separated(
                                  padding: const EdgeInsets.only(
                                    top: 12.0,
                                    left: 12.0,
                                    right: 12.0,
                                  ),
                                  itemCount: state.data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: listView(state.data[index]),
                                      onTap: () {},
                                    );
                                  },
                                  separatorBuilder: (context, _) =>
                                      const SizedBox(height: 26.0),
                                )
                              : GridView.count(
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 8.0,
                                  childAspectRatio: 0.78,
                                  crossAxisCount: 2,
                                  padding: const EdgeInsets.only(
                                    top: 12.0,
                                    left: 12.0,
                                    right: 12.0,
                                  ),
                                  children: state.data.map((person) {
                                    return InkWell(
                                      child: gridView(person),
                                      onTap: () {},
                                    );
                                  }).toList(),
                                );
                        },
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
