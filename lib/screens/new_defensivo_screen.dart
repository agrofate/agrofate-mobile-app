import 'package:agrofate_mobile_app/screens/detail_canteiro_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/datepicker_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class NewDefensivoScreen extends StatefulWidget {
  const NewDefensivoScreen({Key? key}) : super(key: key);

  @override
  _NewDefensivoScreenState createState() => _NewDefensivoScreenState();
}

class _NewDefensivoScreenState extends State<NewDefensivoScreen> {
  final _nameDefController = TextEditingController();
  final _marcaDefController = TextEditingController();
  String _id_safra_escolhida = '';

  DateTime date = DateTime(DateTime.now().year - 500);

  String getDateText() {
    //TODO: arrumar gambiarra - deveria ser date == null
    if (date == DateTime(DateTime.now().year - 500)) {
      return 'Selecione a data de aplicação';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }

  adicionarDefensivo(nome_def, marca_def, data_def) async{
    if(nome_def != ''){
      if(marca_def != ''){
        if(data_def.toString().split('-')[0] != '1521'){        
          SharedPreferences prefs = await SharedPreferences.getInstance();   
          _id_safra_escolhida = (prefs.getString('id_safra_atual') ?? ''); 
          String parametros = "?id_safra="+_id_safra_escolhida+"&nome_def="+nome_def+"&data_def="+data_def.toString()+"&marca_def="+marca_def;
          http.Response url_teste = await http.post(
              "https://future-snowfall-319523.uc.r.appspot.com/insert-novo-defensivo"+parametros);
          var response_login = url_teste.body;
          print(response_login);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCanteiroScreen(), // TODO: enviar para canteiro que a safra foi adc
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insira a data de aplicação'))
          );
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insira a marca do Fertilizante'))
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira o nome do Fertilizante'))
      );
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
        child: SingleChildScrollView(
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
                              titleText:
                              'Adicione um \nnovo defensivo',
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
                          'Preencha os campos abaixo e adicione um novo defensivo à sua safra.',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome do defensivo',
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: _nameDefController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: 'Marca do defensivo',
                      prefixIconData: Icons.business_center_outlined,
                      obscureText: false,
                      textFieldController: _marcaDefController,
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
                      height: 20,
                    ),
                    ButtonWidget(
                      title: 'ADICIONAR DEFENSIVO',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações do defensivo p BD (nome; marca; date)
                        
                        adicionarDefensivo(_nameDefController.text, _marcaDefController.text, date);
                        /*print('Nome def: ${_nameDefController.text}');
                        print('Marca def: ${_marcaDefController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCanteiroScreen(),
                          ),
                        );*/
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
