import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraana_oromiffa/db/database.dart';
import 'package:quraana_oromiffa/md/quraan_model.dart';
import 'package:quraana_oromiffa/scrollbar/draggable_scrolbar.dart';

class HiikkaaQuraana extends StatefulWidget {
  int getId;
  String getOromo;
  HiikkaaQuraana(int getId, String getOromo) {
    this.getId = getId;
    this.getOromo = getOromo;
  }

  @override
  State<StatefulWidget> createState() {
    return HiikkaaQuraanaState(getId, getOromo);
  }
}

class HiikkaaQuraanaState extends State<HiikkaaQuraana> {
  DatabaseHelper db = DatabaseHelper.pConstructor();
  int id;
  String suraName;
   ScrollController controller=ScrollController();
  HiikkaaQuraanaState(int getId, String getOromo) {
    this.id = getId;
    this.suraName = getOromo;
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(suraName),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        )),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: buiderWidget(),
    );
  }

  buiderWidget() {
    return FutureBuilder<List<QuraanModel>>(
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
              var data = snapshot.data[index].getOromiffa;
              var datas = snapshot.data[index].arabiffa;
              if (snapshot.data[index].getOromiffa == null) {
                data = "null";
              }
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30), top: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        datas,
                        style: TextStyle(
                            fontSize: 33,
                            fontFamily: 'arab',
                            color: Colors.black,
                            letterSpacing: 2),
                        textAlign: TextAlign.right,
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                            snapshot.data[index].getAyah
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
                    Padding(padding: EdgeInsets.only(top: 10)),
                    ListTile(
                      title: Text(
                        data,
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'arab',
                            color: Colors.black,
                            wordSpacing: 0.5,
                            letterSpacing: 1.5),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(snapshot.data[index].getAyah.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
              );
            }),
    );
      },
      future: db.getQuraan(id),
    );
  }
}
