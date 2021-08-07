// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi welcome`
  String get welcomeText {
    return Intl.message(
      'Hi welcome',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  String get telaCanteiroTitulo {
    return Intl.message(
      'Seus Canteiros',
      name: 'telaCanteiroTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaCanteiroCampoDataCriacao {
    return Intl.message(
      'Criação: ',
      name: 'telaCanteiroCampoDataCriacao',
      desc: '',
      args: [],
    );
  }

  String get telaCanteiroCampoDataUltima {
    return Intl.message(
      'Última Atualização: ',
      name: 'telaCanteiroCampoDataUltima',
      desc: '',
      args: [],
    );
  }

  String get telaCanteiroBotaoNovoCanteiro {
    return Intl.message(
      'NOVO CANTEIRO',
      name: 'telaCanteiroBotaoNovoCanteiro',
      desc: '',
      args: [],
    );
  }

  String get telaMainBotaoPrevisao {
    return Intl.message(
      'Previsão',
      name: 'telaMainBotaoPrevisao',
      desc: '',
      args: [],
    );
  }

  String get telaMainBotaoCanteiro {
    return Intl.message(
      'Canteiros',
      name: 'telaMainBotaoCanteiro',
      desc: '',
      args: [],
    );
  }

  String get telaMainBotaoDados {
    return Intl.message(
      'Dados',
      name: 'telaMainBotaoDados',
      desc: '',
      args: [],
    );
  }

  String get telaMainBotaoPerfil {
    return Intl.message(
      'Perfil',
      name: 'telaMainBotaoPerfil',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoDataAplicacaoSelecao {
    return Intl.message(
      'Selecione a data de aplicação',
      name: 'telaNovoDefensivoDataAplicacaoSelecao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoDataAplicacaoInsercao {
    return Intl.message(
      'Insira a data de aplicação',
      name: 'telaNovoDefensivoDataAplicacaoInsercao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoMarca {
    return Intl.message(
      'Insira a marca do Defensivo',
      name: 'telaNovoDefensivoMarca',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoNome {
    return Intl.message(
      'Insira o nome do Defensivo',
      name: 'telaNovoDefensivoNome',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoTitulo {
    return Intl.message(
      'Adicione um \nnovo defensivo',
      name: 'telaNovoDefensivoTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoDescricao {
    return Intl.message(
      'Preencha os campos abaixo e adicione um novo defensivo à sua safra.',
      name: 'telaNovoDefensivoDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoBotaoAdicionar {
    return Intl.message(
      'ADICIONAR DEFENSIVO',
      name: 'telaNovoDefensivoBotaoAdicionar',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoTFNome {
    return Intl.message(
      'Nome do defensivo',
      name: 'telaNovoDefensivoTFNome',
      desc: '',
      args: [],
    );
  }

  String get telaNovoDefensivoTFMarca {
    return Intl.message(
      'Marca do defensivo',
      name: 'telaNovoDefensivoTFMarca',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroAdicionarSafra {
    return Intl.message(
      'Adicione uma nova safra',
      name: 'telaDetalheCanteiroAdicionarSafra',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTituloSafra {
    return Intl.message(
      'NOVA SAFRA',
      name: 'telaDetalheCanteiroTituloSafra',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTituloHistorico {
    return Intl.message(
      'HISTÓRICO DE SAFRAS',
      name: 'telaDetalheCanteiroTituloHistorico',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroMensagemHistorico {
    return Intl.message(
      'Não existe histórico de safras! Crie uma nova safra.',
      name: 'telaDetalheCanteiroMensagemHistorico',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroDataPlantacao {
    return Intl.message(
      'Data de plantação: ',
      name: 'telaDetalheCanteiroDataPlantacao',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroUltimaAtualizacao {
    return Intl.message(
      'Última atualização: ',
      name: 'telaDetalheCanteiroUltimaAtualizacao',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroCultura {
    return Intl.message(
      'Cultura: ',
      name: 'telaDetalheCanteiroCultura',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTabFertilizante {
    return Intl.message(
      'Fertilizantes',
      name: 'telaDetalheCanteiroTabFertilizante',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTabDefensivo {
    return Intl.message(
      'Defensivos',
      name: 'telaDetalheCanteiroTabDefensivo',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroDefensivoMarca {
    return Intl.message(
      'Marca: ',
      name: 'telaDetalheCanteiroDefensivoMarca',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroDefensivoDataAplicacao {
    return Intl.message(
      'Data de aplicação: ',
      name: 'telaDetalheCanteiroDefensivoDataAplicacao',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTituloNovoFertilizante {
    return Intl.message(
      'NOVO FERTILIZANTE',
      name: 'telaDetalheCanteiroTituloNovoFertilizante',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTituloNovoDefensivo {
    return Intl.message(
      'NOVO DEFENSIVO',
      name: 'telaDetalheCanteiroTituloNovoDefensivo',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroTituloFinalizarSafra {
    return Intl.message(
      'FINALIZAR SAFRA',
      name: 'telaDetalheCanteiroTituloFinalizarSafra',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheForecastTitulo {
    return Intl.message(
      'Previsão do tempo \ndetalhada',
      name: 'telaDetalheForecastTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheForecastDescricao {
    return Intl.message(
      'Entenda o melhor momento para a produção de acordo com as previsões em sua localização.',
      name: 'telaDetalheForecastDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroTitulo {
    return Intl.message(
      'Atualize \nseu canteiro',
      name: 'telaEditarCanteiroTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroDescricao {
    return Intl.message(
      'Preencha os campos abaixo e atualize as informações do seu canteiro.',
      name: 'telaEditarCanteiroDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroNome {
    return Intl.message(
      'Nome do canteiro',
      name: 'telaEditarCanteiroNome',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroBotao {
    return Intl.message(
      'ATUALIZAR',
      name: 'telaEditarCanteiroBotao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroEscolherImagem {
    return Intl.message(
      'Escolha uma imagem para o canteiro',
      name: 'telaEditarCanteiroEscolherImagem',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroLabelCamera {
    return Intl.message(
      'Câmera',
      name: 'telaEditarCanteiroLabelCamera',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroLabelGaleria {
    return Intl.message(
      'Galeria',
      name: 'telaEditarCanteiroLabelGaleria',
      desc: '',
      args: [],
    );
  }

  String get telaLoginFrase {
    return Intl.message(
      'Pensando um futuro mais consciente',
      name: 'telaLoginFrase',
      desc: '',
      args: [],
    );
  }

  String get telaLoginEsqueceuSenha {
    return Intl.message(
      'Esqueceu a senha?',
      name: 'telaLoginEsqueceuSenha',
      desc: '',
      args: [],
    );
  }

  String get telaLoginBotaoCadastrar {
    return Intl.message(
      'CADASTRAR',
      name: 'telaLoginBotaoCadastrar',
      desc: '',
      args: [],
    );
  }

  String get telaLoginBotaoEntrar {
    return Intl.message(
      'ENTRAR',
      name: 'telaLoginBotaoEntrar',
      desc: '',
      args: [],
    );
  }

  String get telaConfigTitle {
    return Intl.message(
      'Configurações',
      name: 'telaConfigTitle',
      desc: '',
      args: [],
    );
  }

  String get telaConfigDescricao {
    return Intl.message(
      'Aqui você pode editar suas informações de perfil e também sair do aplicativo.',
      name: 'telaConfigDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaPerfilDesenvolvimento {
    return Intl.message(
      'Em desenvolvimento',
      name: 'telaPerfilDesenvolvimento',
      desc: '',
      args: [],
    );
  }

  String get telaDadosBotaoNovoEquipamento {
    return Intl.message(
      'NOVO EQUIPAMENTO',
      name: 'telaDadosBotaoNovoEquipamento',
      desc: '',
      args: [],
    );
  }

  String get telaDadosUmidade {
    return Intl.message(
      'Umidade do solo',
      name: 'telaDadosUmidade',
      desc: '',
      args: [],
    );
  }

  String get telaDadosPH {
    return Intl.message(
      'Acidez do Solo - pH',
      name: 'telaDadosPH',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}