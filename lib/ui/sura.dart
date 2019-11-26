import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quraana_oromiffa/Abouts/about_us.dart';
import 'package:quraana_oromiffa/db/database.dart';
import 'package:quraana_oromiffa/md/sura_model.dart';
import 'package:quraana_oromiffa/preference/preference_page.dart';
import 'package:quraana_oromiffa/scrollbar/draggable_scrolbar.dart';
import 'package:quraana_oromiffa/ui/hiika_quraana.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sura extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuraState();
  }

  static Future setTheme(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', s);
  }
}

class SuraState extends State<Sura> {
  DatabaseHelper db = DatabaseHelper.pConstructor();
  ScrollController controller = ScrollController();
  BuildContext context1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Suurawwan"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          )),
          centerTitle: true,
          actions: <Widget>[
            // action button
            PopupMenuButton(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return popups.map((PopUp popup) {
                  return new PopupMenuItem<PopUp>(
                    value: popup,
                    child: new ListTile(
                      leading: popup.icon,
                      title: Text(popup.title),
                    ),
                  );
                }).toList();
              },
            ),
          ]),
      body: buiderWidget(),
    );
  }

  buiderWidget() {
    return FutureBuilder<List<SuraModel>>(
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return DraggableScrollbar.arrows(
            alwaysVisibleScrollThumb: false,
            padding: EdgeInsets.only(right: 4.0),
            controller: controller,
            child: ListView.builder(
                controller: controller,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                            top: Radius.circular(30))),
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].getOromo,
                        style: TextStyle(fontSize: 20, fontFamily: 'arab'),
                      ),
                      subtitle: Text(
                        snapshot.data[index].getArabic,
                        style: TextStyle(fontSize: 25, fontFamily: 'arab'),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HiikkaaQuraana(
                              snapshot.data[index].getId,
                              snapshot.data[index].getOromo))),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(snapshot.data[index].getId.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                            snapshot.data[index].getId
                                .toString()
                                .replaceAll('0', '۰')
                                .replaceAll('1', '۱')
                                .replaceAll('2', '۲')
                                .replaceAll('3', '۳')
                                .replaceAll('4', '۴')
                                .replaceAll('5', '۵')
                                .replaceAll('6', '۶')
                                .replaceAll('7', '۷')
                                .replaceAll('8', '۸')
                                .replaceAll('9', '۹'),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  );
                }));
      },
      future: db.getSura(),
    );
  }

  void choiceAction(PopUp value) {
    switch (value.title) {
      case 'Setting':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PreferencePages(),
        ));
        break;
      case 'About':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUs(),
        ));
        break;
      case 'Exit':
        SystemNavigator.pop();
        break;
    }
  }
}

class PopUp {
  final String title;
  final Icon icon;
  const PopUp({this.title, this.icon});
}

const List<PopUp> popups = <PopUp>[
  const PopUp(title: 'Setting', icon: const Icon(Icons.settings)),
  const PopUp(title: 'About', icon: const Icon(Icons.supervised_user_circle)),
  const PopUp(title: 'Exit', icon: const Icon(Icons.exit_to_app))
];
