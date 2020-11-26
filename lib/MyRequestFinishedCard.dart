import 'package:flutter/material.dart';

import 'ConvertNumber.dart';
import 'FirebaseGetTrashs.dart';
import 'SizeConfig.dart';

class MyRequestFinishedCard extends StatelessWidget {
  final TrashData trash;
  final int date;
  final double trashcoins;
  final double weight;
  final double stage;
  final double rating;

  const MyRequestFinishedCard(
      {Key key,
      this.date,
      this.trash,
      this.trashcoins,
      this.weight,
      this.stage,
      this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stageDesc = "";

    String getStage(stage) {
      switch (stage) {
        case 1:
          stageDesc = "Aguardando Coletor 😙";
          break;
        case 2:
          stageDesc = "Coleta Confirmada 👍";
          break;
        case 3:
          stageDesc = "Coletor a Caminho 🚚";
          break;
        case 4:
          stageDesc = "Coletor Chegou 👋";
          break;
        case 5:
          stageDesc = "Coleta Finalizada 🏆";
          break;
        default:
          stageDesc = "Aguardando Coletor 😙";
      }
      return stageDesc;
    }

    var data = DateTime.fromMillisecondsSinceEpoch(date);
    print(data);
    int numWeekday = data.weekday;
    print(numWeekday);
    int day = data.day;
    print(day);
    int numMonth = data.month;
    print(numMonth);
    String weekday;
    String month;

    switch (numMonth) {
      case 1:
        month = 'JAN';
        break;
      case 2:
        month = 'FEV';
        break;
      case 3:
        month = 'MAR';
        break;
      case 4:
        month = 'ABR';
        break;
      case 5:
        month = 'MAI';
        break;
      case 6:
        month = 'JUN';
        break;
      case 7:
        month = 'JUL';
        break;
      case 8:
        month = 'AGO';
        break;
      case 9:
        month = 'SET';
        break;
      case 10:
        month = 'OUT';
        break;
      case 11:
        month = 'NOV';
        break;
      case 12:
        month = 'DEZ';
        break;
    }

    print(weekday);

    print(month);

    switch (numWeekday) {
      case 1:
        weekday = 'Seg';
        break;
      case 2:
        weekday = 'Ter';
        break;
      case 3:
        weekday = 'Qua';
        break;
      case 4:
        weekday = 'Qui';
        break;
      case 5:
        weekday = 'Sex';
        break;
      case 6:
        weekday = 'Sab';
        break;
      case 7:
        weekday = 'Dom';
        break;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      height: 285,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(4),
                child: Text('$weekday, $day $month',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  margin: EdgeInsets.all(4),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
          Divider(
            height: 4,
            color: Colors.grey,
            indent: 2,
          ),
          Container(
            margin: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trashcoins",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                        fontWeight: FontWeight.normal)),
                Text(
                    ConvertNumber().convertNumber(trashcoins.toString()) +
                        " Tc",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Peso",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                        fontWeight: FontWeight.normal)),
                Text(ConvertNumber().convertNumber(weight.toString()) + " Kg",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Divider(),
          Center(
            child: Container(
              margin: EdgeInsets.all(4),
              child: Text('${getStage(stage)} em ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.of(context).dynamicScale(size: 18),
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Divider(),
          Container(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    //color: Colors.deepPurple,
                    //border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    child: Center(
                        child: Text("Ajuda",
                            style:
                                TextStyle(fontSize: 20, color: Colors.green)))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
