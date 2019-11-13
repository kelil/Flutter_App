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
  ScrollController controller = ScrollController();
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
          backgroundColor: Theme.of(context).primaryColor,
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
                          bottom: Radius.circular(30),
                          top: Radius.circular(30))),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          datas,
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'arab',
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
                              fontSize: 20,
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
                      ),
                      ListTile(
                        title: Text(
                            snapshot.data[index].getTasfiir != null
                                ? '(1)'
                                : '',
                            style: TextStyle(color: Colors.blueAccent),
                            textAlign: TextAlign.center),
                        onTap: () => snapshot.data[index].getTasfiir != null
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildAboutDialog(context,
                                        snapshot.data[index].getTasfiir))
                            : debugPrint("hello"),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
      future: db.getQuraan(id),
    );
  }

  Widget _buildAboutDialog(BuildContext context, String getTasfiir) {
    return new AlertDialog(
      title: const Text('Tasfiir'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(getTasfiir),
          _buildLogoAttribution(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Ok'),
        ),
      ],
    );
  }

  Widget _buildAboutText(String getTasfiir) {
    return new RichText(
      text: new TextSpan(
        text: getTasfiir,
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[],
      ),
    );
  }

  Widget _buildLogoAttribution() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: new Image.asset(
              "assets/images/quran_icon.png",
              width: 32.0,
            ),
          ),
          const Expanded(
            child: const Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: const Text(
                '',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
