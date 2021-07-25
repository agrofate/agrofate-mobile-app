import 'dart:convert';

import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/datepicker_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/imagefield_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewSafraScreen extends StatefulWidget {
  const NewSafraScreen({Key? key}) : super(key: key);

  @override
  _NewSafraScreenState createState() => _NewSafraScreenState();
}

class _NewSafraScreenState extends State<NewSafraScreen> {
  final _nameSafraController = TextEditingController();
  var nome_canteiro;
  bool loading = true;
  //var data_cultura;
  List data_cultura = List.empty();
  String? countryid; 
  var _mySelection;

  String dropdownValue = '';
  String _id_canteiro_escolhido = '';
  String hintValue = 'Selecione a cultura';
  List<String> culturasItems = [
    "Couve",
    "Alface"
  ]; // TODO: puxar lista de culturas do banco?

  DateTime date = DateTime(DateTime.now().year - 500);

  @override
  void initState() {
    super.initState();
    _procuraNomeCanteiro();
    procuraCultura();
  }

  adicionarSafra(nome_safra, data_safra, tipo_cultura) async{
    if(nome_safra != ''){
      if(data_safra.toString().split('-')[0] != '1521'){
        if(tipo_cultura != null){
          SharedPreferences prefs = await SharedPreferences.getInstance();   
          _id_canteiro_escolhido =  (prefs.getString('id_canteiro_escolhido') ?? ''); 
          String parametros = "?id_canteiro="+_id_canteiro_escolhido+"&nome_safra="+nome_safra+"&data_safra="+data_safra.toString()+"&id_cultura="+tipo_cultura;
          http.Response url_teste = await http.post(
              "https://future-snowfall-319523.uc.r.appspot.com/insert-nova-safra"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CanteirosScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insira o tipo da cultura'))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insira a data da Safra'))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira o nome da Safra'))
      );
    }
    print(nome_safra);
    print(data_safra);
    print(tipo_cultura);
  }

  Future procuraCultura() async {
    http.Response url_teste = await http.get(
        "https://future-snowfall-319523.uc.r.appspot.com/read-all-cultura");
    var response_login = jsonDecode(url_teste.body);
    data_cultura = response_login;
    print(response_login);
    print(response_login.length);

    setState(() {
      data_cultura = response_login;
      loading = false;
    });
  }

  Future _procuraNomeCanteiro() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nome_canteiro =  (prefs.getString('nome_canteiro_escolhido') ?? '');
    setState(() {        
      nome_canteiro = (prefs.getString('nome_canteiro_escolhido') ?? '');
    });
  }

  String getDateText(){    
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return 'Selecione a data de plantação';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future pickDate(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        locale: Locale('pt', 'BR'),
      );

      if (newDate == null) return;

      setState(() {
        // TODO: enviar date para BD
        date = newDate;
      });
    }
    return Scaffold(      
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: 
        FutureBuilder(
          builder: (context, text){
            if (loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  TitleFormsWidget(
                                    // TODO: recuperar nome do canteiro na base
                                    titleText:
                                        'Adicione uma safra no \n' + nome_canteiro,
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
                                    'Preencha os campos abaixo e adicione uma nova safra ao seu canteiro.',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          TextFieldWidget(
                            hintText: 'Nome da safra',
                            prefixIconData: Icons.article_outlined,
                            obscureText: false,
                            textFieldController: _nameSafraController,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DatePickerWidget(
                            text: getDateText(),
                            onTap: () {
                              pickDate(context);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 53,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: const Border.fromBorderSide(BorderSide.none),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.seedling,
                                  size: 18,
                                  color: Color(0xff575c63),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: size.width * 0.67,
                                  child: Center(
                                    /*child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: new Text(hintValue),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(
                                          color: Color(0xff575c63),
                                          fontSize: 14.0,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                            hintValue = dropdownValue;
                                          });
                                        },
                                        items: data_cultura
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: data_cultura[0],
                                            child: Text(data_cultura[1]),
                                          );
                                        }).toList(),
                                      ),
                                    ),*/
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: new Text(hintValue),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(
                                          color: Color(0xff575c63),
                                          fontSize: 14.0,
                                        ),
                                        items: data_cultura.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(
                                              item[1],   
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            value: item[0].toString()                                                                         
                                          );  
                                        }).toList(),
                                        onChanged: (String? newVal) {
                                          setState(() {
                                            countryid = newVal;
                                            print(countryid.toString());
                                          });
                                        },
                                        value: countryid, 
                                      )
                                    )
                                    /*child: new DropdownButton(
                                      items: data_cultura.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item[1]),
                                          value: item[0].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelection = newVal;
                                        });
                                      },
                                      value: _mySelection,
                                    ),*/
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            title: 'ADICIONAR SAFRA',
                            hasBorder: false,
                            onClicked: () {
                              // TODO: subir informações da safra para nuvem (nome; date; dropdownValue)
                              print('Safra: ${_nameSafraController.text}');
                              adicionarSafra(_nameSafraController.text, date, countryid);
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CanteirosScreen(), // TODO: enviar para canteiro que a safra foi adc
                                ),
                              );*/
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        ),
      ),
    );
  }
}
