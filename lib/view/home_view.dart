import 'package:flutter/material.dart';
import 'package:izmir_weather/model/weather.dart';
import 'package:lottie/lottie.dart';
import '../viewModel/home_view_model.dart';

class HomeView extends HomeViewModel {

  List<String> months=[
    "Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık"
  ];
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
              child: Column(
          children: [
            topCard(context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: SizedBox(
                
                child: Text("2020",style: TextStyle(fontSize: 32,color: Colors.white),),
              ),
            ),
            listViewUI(),
          ],
        ),
      ),
    );
  }

  Container listViewUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder(
        future: http_deneme.getHttp,
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(50),
              child: Lottie.asset('assets/weather_lottie.json'),
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: context.width,
              height: context.height * 0.58,
              child: listViewArea(snapshot),
            );
          } else {
            return Text("Veri Yok");
          }
        },
      ),
    );
  }

  Container topCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: topCardUI(),
      width: context.width,
      height: context.height * 0.4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 12,
            blurRadius: 20,
            offset: Offset(0, 9), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        image: imageArea(),
      ),
    );
  }

  Column topCardUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(
          flex: 2,
        ),
        Text(
          "Izmir",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w600),
        ),
        Spacer(
          flex: 3,
        ),
      ],
    );
  }

  DecorationImage imageArea() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage("https://wallpaperaccess.com/full/1928532.jpg"),
    );
  }

  ListView listViewArea(AsyncSnapshot<Weather> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.consolidatedWeather.length,
        itemBuilder: (context, int a) {
          return Card(
            child: listTileWidget(snapshot, a),
          );
        });
  }



  ListTile listTileWidget(AsyncSnapshot<Weather> snapshot, int a) {
    return ListTile(
      title: Text(
          "Tarih : " + getDay(snapshot, a) + " " + months[int.parse(getMonth(snapshot, a))-1]),
      subtitle:
          Text(snapshot.data.consolidatedWeather[a].theTemp.toStringAsFixed(1)),
      trailing: Image.network(
          "https://www.metaweather.com/static/img/weather/png/${snapshot.data.consolidatedWeather[a].weatherStateAbbr}.png"),
    );
  }

  String getDay(AsyncSnapshot<Weather> snapshot, int a){
    var date = snapshot.data.consolidatedWeather[a].applicableDate;
    String day  = date.substring(date.length - 2);
    return day;
  }

  String getMonth(AsyncSnapshot<Weather> snapshot, int a){
    var date = snapshot.data.consolidatedWeather[a].applicableDate;
    String month = date.substring(5,7);
    return month;
  }

  String getYear(AsyncSnapshot<Weather> snapshot, int a){
    var date = snapshot.data.consolidatedWeather[a].applicableDate;
    String year = date.substring(0,4);
    return year;
  }
}

extension ContextExtentions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

//https://assets10.lottiefiles.com/packages/lf20_kd7SIg.json
