import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraana_oromiffa/db/database.dart';
import 'package:quraana_oromiffa/md/sura_model.dart';
import 'package:quraana_oromiffa/scrollbar/draggable_scrolbar.dart';
import 'package:quraana_oromiffa/ui/hiika_quraana.dart';

class Sura extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuraState();
  }
}

class SuraState extends State<Sura> {
  DatabaseHelper db = DatabaseHelper.pConstructor();
   ScrollController controller=ScrollController();

  var english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.brown, accentColor: Colors.yellowAccent),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Suurawwan"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            )),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: buiderWidget(),
        ));
  }

  buiderWidget() {
    return FutureBuilder<List<SuraModel>>(
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

       return DraggableScrollbar.arrows(
      alwaysVisibleScrollThumb: false,
      backgroundColor: Colors.grey[850],
      padding: EdgeInsets.only(right: 4.0),
      controller: controller,
        child: ListView.builder(
          controller: controller,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30), top: Radius.circular(30))),
                child: ListTile(
                  title: Text(
                    snapshot.data[index].getOromo,
                    style: TextStyle(fontSize: 25, fontFamily: 'arab'),
                  ),
                  subtitle: Text(
                    snapshot.data[index].getArabic,
                    style: TextStyle(fontSize: 30, fontFamily: 'arab'),
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
            })
       );
      },
      future: db.getSura(),
    );
  }
}
