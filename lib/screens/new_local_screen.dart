import 'dart:async';

import 'package:agrofate_mobile_app/generated/l10n.dart';
import 'package:agrofate_mobile_app/utilities/constants.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class NewLocalScreen extends StatefulWidget {
  const NewLocalScreen({Key key}) : super(key: key);

  @override
  _NewLocalScreenState createState() => _NewLocalScreenState();
}

class _NewLocalScreenState extends State<NewLocalScreen> {
  GoogleMapController mapController;

  static const LatLng _latLng = const LatLng(-23.5638291, -46.007628);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                            titleText: 'Adicione um \nnovo local',
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
                            'Preencha com seu endereço ou selecione no mapa o local para receber a previsão do tempo localizada.',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SearchMapPlaceWidget(
                    apiKey: "AIzaSyBm7uLN2PtfZQ77T4owUxmq0kgOs8Z_ZUs",
                    placeholder: "Preencha com o endereço",
                    placeType: PlaceType.address,
                    hasClearButton: true,
                    iconColor: kGreenColor,
                    language: 'pt',
                    onSelected: (Place place) async {
                      Geolocation geolocation = await place.geolocation;
                      mapController.animateCamera(
                          CameraUpdate.newLatLng(geolocation.coordinates));
                      mapController.animateCamera(
                          CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
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
                  ButtonWidget(
                    title: "ADICIONAR LOCAL",
                    hasBorder: false,
                    onClicked: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.of(context).telaPerfilDesenvolvimento )));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
