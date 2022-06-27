import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'generated/l10n.dart';
import 'constants/app_assets.dart';
import 'constants/app_colors.dart';
import 'constants/app_styles.dart';

class PersonsScreen extends StatefulWidget {
  const PersonsScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<PersonsScreen> createState() => _PersonsScreenState();
}

class Person {
  String name;
  String species;
  String status;
  String gender;
  String image;
  Person(this.name, this.species, this.status, this.gender, this.image);
}

class _PersonsScreenState extends State<PersonsScreen> {
  List<Person> personsList = [];
  var isGridView = false;

  _PersonsScreenState() {
    personsList.add(Person(
        'Рик Санчез', 'Человек', 'Dead', 'Мужской', AppAssets.images.noAvatar));
    personsList.add(Person(
        'Алан Райс', 'Человек', 'Dead', 'Мужской', AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Женский',
        AppAssets.images.noAvatar));
    personsList.add(Person('Морти Смит', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person(
        'Алан Райс', 'Человек', 'Dead', 'Мужской', AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Женский',
        AppAssets.images.noAvatar));
    personsList.add(Person('Морти Смит', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person(
        'Алан Райс', 'Человек', 'Dead', 'Мужской', AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Женский',
        AppAssets.images.noAvatar));
    personsList.add(Person('Морти Смит', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
    personsList.add(Person(
        'Алан Райс', 'Человек', 'Dead', 'Мужской', AppAssets.images.noAvatar));
    personsList.add(Person('Рик Санчез', 'Человек', 'Alive', 'Женский',
        AppAssets.images.noAvatar));
    personsList.add(Person('Морти Смит', 'Человек', 'Alive', 'Мужской',
        AppAssets.images.noAvatar));
  }

  Widget listView(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Image.asset(
            personsList[index].image,
            width: 90,
            height: 90,
          ),
          const SizedBox(width: 16), //отступ
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  personsList[index].status == "Dead"
                      ? S.of(context).dead.toUpperCase()
                      : S.of(context).alive.toUpperCase(),
                  style: AppStyles.s10w500.copyWith(
                      color: personsList[index].status == "Dead"
                          ? Colors.red
                          : Colors.green),
                ),
                Text(
                  personsList[index].name,
                  style: AppStyles.s12w700.copyWith(color: AppColors.mainText),
                ),
              ])
        ],
      ),
    );
  }

  Widget countPersonsView() {
    return Text(
      "${S.of(context).personsCount}: ${personsList.length}".toUpperCase(),
      style: AppStyles.s10w500.copyWith(
        letterSpacing: 1.5,
        color: AppColors.neutral2,
      ),
    );
  }

  Widget gridListIconButtons() {
    return IconButton(
      icon: Icon(isGridView ? Icons.grid_view : Icons.list),
      iconSize: 28.0,
      color: AppColors.neutral2,
      onPressed: () {
        setState(
          () {
            isGridView = !isGridView;
          },
        );
      },
    );
  }

  Widget gridView(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          Image.asset(
            personsList[index].image,
            width: 90,
            height: 90,
          ),
          const SizedBox(height: 16), //отступ
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                personsList[index].status == "Dead"
                    ? S.of(context).dead.toUpperCase()
                    : S.of(context).alive.toUpperCase(),
                style: AppStyles.s10w500.copyWith(
                    color: personsList[index].status == "Dead"
                        ? Colors.red
                        : Colors.green),
              ),
              Text(personsList[index].name,
                  style: AppStyles.s12w700.copyWith(color: AppColors.mainText)),
              Text(
                  "${personsList[index].species == 'Human' ? S.of(context).species : S.of(context).species}, "
                  "${personsList[index].gender == 'Men' ? S.of(context).men : S.of(context).women}",
                  style: AppStyles.s10w500.copyWith(color: AppColors.neutral2)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  countPersonsView(),
                  gridListIconButtons(),
                ],
              ),
              Expanded(
                child: isGridView
                    ? ListView.builder(
                        itemCount: personsList.length,
                        itemBuilder: (context, index) =>
                            listView(context, index),
                      )
                    : GridView.builder(
                        itemCount: personsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0),
                        itemBuilder: (context, index) =>
                            gridView(context, index),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
