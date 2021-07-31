import 'package:agrofate_mobile_app/screens/canteiros_screen.dart';
import 'package:agrofate_mobile_app/widgets/button_widget.dart';
import 'package:agrofate_mobile_app/widgets/description_forms_widget.dart';
import 'package:agrofate_mobile_app/widgets/imagefield_widget.dart';
import 'package:agrofate_mobile_app/widgets/textfield_widget.dart';
import 'package:agrofate_mobile_app/widgets/title_forms_widget.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewCanteiroScreen extends StatefulWidget {
  const NewCanteiroScreen({Key? key}) : super(key: key);

  @override
  _NewCanteiroScreenState createState() => _NewCanteiroScreenState();
}

class _NewCanteiroScreenState extends State<NewCanteiroScreen> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  final nameCanteiroController = TextEditingController();
  String _id_canteiro_escolhido = '';
  String _id_user = '';

  adicionarCanteiro(nome_cant) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id_user = (prefs.getString('id_user') ?? '');
    });
    if(nome_cant != ''){       
      SharedPreferences prefs = await SharedPreferences.getInstance();   
      String parametros = "?nome_canteiro="+nome_cant+"&id_usuario="+_id_user;
      http.Response url_teste = await http.post(
          "https://future-snowfall-319523.uc.r.appspot.com/insert-novo-canteiro"+parametros);
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
        const SnackBar(content: Text('Insira o nome do Canteiro'))
      );
    }
  }

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
      body: Form(
        child: SingleChildScrollView(
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
                        TitleFormsWidget(
                          titleText: 'Adicione \num canteiro',
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
                              'Preencha os campos abaixo e crie um novo canteiro.',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFieldWidget(
                      hintText: 'Nome do canteiro',
                      prefixIconData: Icons.article_outlined,
                      obscureText: false,
                      textFieldController: nameCanteiroController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageFieldWidget(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      title: 'ADICIONAR',
                      hasBorder: false,
                      onClicked: () {
                        // TODO: subir informações do canteiro para nuvem
                        
                        adicionarCanteiro(nameCanteiroController.text);
                        /*print('Nome: ${nameCanteiroController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CanteirosScreen(),
                          ),
                        );*/
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    print(pickedFile.path);
    setState(() {
      _imageFile = pickedFile; // TODO: essa imagem irá subir para o servidor - var _imageFile declarada lá encima
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Escolha uma imagem para o canteiro",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text("Câmera"),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.file_upload_outlined),
                label: Text("Galeria"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
