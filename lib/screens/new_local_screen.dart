import 'dart:async';
import 'dart:convert';

import 'package:agrofate_mobile_app/classes/language.dart';
import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../LanguageChangeProvider.dart';
import 'main_screens.dart';

class NewLocalScreen extends StatefulWidget {
  const NewLocalScreen({Key key}) : super(key: key);

  @override
  _NewLocalScreenState createState() => _NewLocalScreenState();
}

class _NewLocalScreenState extends State<NewLocalScreen> {
  GoogleMapController mapController;

  static LatLng _latLng = const LatLng(-23.5638291, -46.007628);
  String _id_user = '';
  int _state = 0;


  adicionarLocal(latlng) async{
    var latLng;
    latLng = latlng.toJson();
    print(latLng);
    setState(() {
      _state = 1;
    });
    if(latLng[0] == -23.5638291 && latLng[1] == -46.00762800000001){
      print("Selecione o local");
      setState(() {
        _state = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selecione o local")));
    }else{
      print(latLng);  
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _id_user = (prefs.getString('id_user') ?? '');
      });
      String parametros = "?id_user="+_id_user+"&lat_local="+latLng[0].toString()+"&long_local="+latLng[1].toString();
      http.Response url_teste = await http.post(
          "https://intrepid-pager-329723.uc.r.appspot.com/insert-novo-local"+parametros);

      setState(() {
        _state = 2;
      });

      Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreens(myInt:0)),
                (Route<dynamic> route) => false,
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _changeLanguage(Language language) async {
      //Locale _locale = await setLocale(language.languageCode);
      print(language.languageCode);
      setState(() {
        context.read<LanguageChangeProvider>().changeLocale(language.languageCode);      
      });
      //MyHomePage.setLocale(context, _locale);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                onChanged: (Language language) {
                  _changeLanguage(language);
                },
                items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
              ),
          ),
        ]
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          TitleFormsWidget(
                            titleText: S.of(context).telaNovoLocalTitulo,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      DescriptionFormsWidget(
                        descriptionText:
                            S.of(context).telaNovoLocalDescricao,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SearchMapPlaceWidget(
                    apiKey: "AIzaSyBm7uLN2PtfZQ77T4owUxmq0kgOs8Z_ZUs",
                    placeholder: S.of(context).telaNovoLocalPlaceholder,
                    placeType: PlaceType.address,
                    hasClearButton: true,
                    iconColor: kGreenColor,
                    language: S.of(context).telaNovoLocalLanguage,
                    onSelected: (Place place) async {
                      Geolocation geolocation = await place.geolocation;
                      mapController.animateCamera(
                          CameraUpdate.newLatLng(geolocation.coordinates));
                      mapController.animateCamera(
                          CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                      print("LatLng: ");
                      _latLng = geolocation.coordinates;
                      print(geolocation.coordinates);
                      print(geolocation.bounds);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: SizedBox(
                      height: size.height * 0.35,
                      child: GoogleMap(
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          setState(() {
                            mapController = googleMapController;
                            print("LatLng3: ");
                            print(mapController);
                          });
                        },
                        initialCameraPosition: CameraPosition(
                          zoom: 15.0,
                          target: _latLng,
                        ),
                        mapType: MapType.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /*ButtonWidget(
                    title: "ADICIONAR LOCAL",
                    hasBorder: false,
                    onClicked: () {
                      //ScaffoldMessenger.of(context).showSnackBar(
                      //    SnackBar(content: Text(S.of(context).telaPerfilDesenvolvimento )));
                      //print("LatLng 2:");
                      adicionarLocal(_latLng);
                      //print(_latLng);
                    },
                  ),*/
                  Padding(                  
                    padding: const EdgeInsets.all(0.0),                        
                    child: new MaterialButton(
                      child: setUpButtonChild(),                    
                      onPressed: () {
                        setState(() {
                          if (_state == 0) {
                            adicionarLocal(_latLng);
                          }
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      minWidth: double.infinity,
                      height: 58.0,
                      color: kGreenColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        S.of(context).telaNovoLocalBotaoAdicionar,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}

class LatLong {
}
