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

  String get telaNovoCanteiroAdicionar {
    return Intl.message(
      'ADICIONAR',
      name: 'telaNovoCanteiroAdicionar',
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

  String get telaNovoFertilizanteDataAplicacaoSelecao {
    return Intl.message(
      'Selecione a data de aplicação',
      name: 'telaNovoFertilizanteDataAplicacaoSelecao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteDataAplicacaoInsercao {
    return Intl.message(
      'Insira a data de aplicação',
      name: 'telaNovoFertilizanteDataAplicacaoInsercao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteMarca {
    return Intl.message(
      'Insira a marca do fertilizante',
      name: 'telaNovoFertilizanteMarca',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteNome {
    return Intl.message(
      'Insira o nome do fertilizante',
      name: 'telaNovoFertilizanteNome',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteTitulo {
    return Intl.message(
      'Adicione um \nnovo fertilizante',
      name: 'telaNovoFertilizanteTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteDescricao {
    return Intl.message(
      'Preencha os campos abaixo e adicione um novo fertilizante à sua safra.',
      name: 'telaNovoFertilizanteDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteBotaoAdicionar {
    return Intl.message(
      'ADICIONAR FERTILIZANTE',
      name: 'telaNovoFertilizanteBotaoAdicionar',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteTFNome {
    return Intl.message(
      'Nome do fertilizante',
      name: 'telaNovoFertilizanteTFNome',
      desc: '',
      args: [],
    );
  }

  String get telaNovoFertilizanteTFMarca {
    return Intl.message(
      'Tipo de fertilizante',
      name: 'telaNovoFertilizanteTFMarca',
      desc: '',
      args: [],
    );
  }

  String get telaNovaSafraTitulo {
    return Intl.message(
      'Adicione uma \n safra no \n',
      name: 'telaNovaSafraTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaNovaSafraDescricao {
    return Intl.message(
      'Preencha os campos abaixo e adicione uma nova safra ao seu canteiro.',
      name: 'telaNovaSafraDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaNovaSafraTFNome {
    return Intl.message(
      'Nome da Safra',
      name: 'telaNovaSafraTFNome',
      desc: '',
      args: [],
    );
  }

  String get telaNovaSafraBotaoAdicionar {
    return Intl.message(
      'ADICIONAR SAFRA',
      name: 'telaNovaSafraBotaoAdicionar',
      desc: '',
      args: [],
    );
  }

  String get telaNovoLocalTitulo {
    return Intl.message(
      'Adicione um \nnovo local',
      name: 'telaNovoLocalTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaNovoLocalDescricao {
    return Intl.message(
      'Preencha com seu endereço ou selecione no mapa o local para receber a previsão do tempo localizada.',
      name: 'telaNovoLocalDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaNovoLocalPlaceholder {
    return Intl.message(
      'Preencha com o endereço',
      name: 'telaNovoLocalPlaceholder',
      desc: '',
      args: [],
    );
  }

  String get telaNovoLocalLanguage {
    return Intl.message(
      'pt',
      name: 'telaNovoLocalLanguage',
      desc: '',
      args: [],
    );
  }

  String get telaNovoLocalBotaoAdicionar {
    return Intl.message(
      'ADICIONAR LOCAL',
      name: 'telaNovoLocalBotaoAdicionar',
      desc: '',
      args: [],
    );
  }

  String get telaForecastBotaoNovoLocal {
    return Intl.message(
      'NOVO LOCAL',
      name: 'telaForecastBotaoNovoLocal',
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

  String get telaDetalheCanteiroAlertTitle {
    return Intl.message(
      'Finalizar Safra',
      name: 'telaDetalheCanteiroAlertTitle',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroAlertDescricao {
    return Intl.message(
      'Deseja realmente finalizar a safra?',
      name: 'telaDetalheCanteiroAlertDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroAlertEscolha1 {
    return Intl.message(
      'Não',
      name: 'telaDetalheCanteiroAlertEscolha1',
      desc: '',
      args: [],
    );
  }

  String get telaDetalheCanteiroAlertEscolha2 {
    return Intl.message(
      'Sim',
      name: 'telaDetalheCanteiroAlertEscolha2',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoAlertTitle {
    return Intl.message(
      'Excluir Defensivo',
      name: 'telaEditarDefensivoAlertTitle',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoAlertDescricao {
    return Intl.message(
      'Deseja realmente excluir o defensivo?',
      name: 'telaEditarDefensivoAlertDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteAlertTitle {
    return Intl.message(
      'Excluir Fertilizante',
      name: 'telaEditarFertilizanteAlertTitle',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteAlertDescricao {
    return Intl.message(
      'Deseja realmente excluir o fertilizante?',
      name: 'telaEditarFertilizanteAlertDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarSafraAlertTitle {
    return Intl.message(
      'Excluir Safra',
      name: 'telaEditarSafraAlertTitle',
      desc: '',
      args: [],
    );
  }

  String get telaEditarSafraAlertDescricao {
    return Intl.message(
      'Deseja realmente excluir a safra?',
      name: 'telaEditarSafraAlertDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteTitulo {
    return Intl.message(
      'Edite o \nfertilizante',
      name: 'telaEditarFertilizanteTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteDescricao {
    return Intl.message(
      'Preencha os campos abaixo e atualize o fertilizante.',
      name: 'telaEditarFertilizanteDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteNome {
    return Intl.message(
      'Nome do fertilizante',
      name: 'telaEditarFertilizanteNome',
      desc: '',
      args: [],
    );
  }

  String get telaEditarFertilizanteTipo {
    return Intl.message(
      'Tipo do fertilizante',
      name: 'telaEditarFertilizanteTipo',
      desc: '',
      args: [],
    );
  }
  
  String get telaEditarFertilizanteBotao {
    return Intl.message(
      'ATUALIZAR FERTILIZANTE',
      name: 'telaEditarFertilizanteBotao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoTitulo {
    return Intl.message(
      'Edite o \ndefensivo',
      name: 'telaEditarDefensivoTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoDescricao {
    return Intl.message(
      'Preencha os campos abaixo e atualize o defensivo.',
      name: 'telaEditarDefensivoDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoNome {
    return Intl.message(
      'Nome do defensivo',
      name: 'telaEditarDefensivoNome',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoTipo {
    return Intl.message(
      'Tipo do defensivo',
      name: 'telaEditarDefensivoTipo',
      desc: '',
      args: [],
    );
  }

  String get telaEditarDefensivoBotao {
    return Intl.message(
      'ATUALIZAR DEFENSIVO',
      name: 'telaEditarDefensivoBotao',
      desc: '',
      args: [],
    );
  }

  String get telaHistoricoSafraTitulo {
    return Intl.message(
      'Histórico de safras no \n',
      name: 'telaHistoricoSafraTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaHistoricoSafraDescricao {
    return Intl.message(
      'Visualize o histórico de safras do seu canteiro.',
      name: 'telaHistoricoSafraDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaHistoricoSafraPlantacao {
    return Intl.message(
      'Plantação: ',
      name: 'telaHistoricoSafraPlantacao',
      desc: '',
      args: [],
    );
  }

  String get telaHistoricoSafraCultura {
    return Intl.message(
      'Cultura: ',
      name: 'telaHistoricoSafraCultura',
      desc: '',
      args: [],
    );
  }

  String get telaForecastDiadaSemana {
    return Intl.message(
      'pt_Br',
      name: 'telaForecastDiadaSemana',
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

  String get telaEditarCanteiroAlertTitle {
    return Intl.message(
      'Excluir Canteiro',
      name: 'telaEditarCanteiroAlertTitle',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroAlertDescricao {
    return Intl.message(
      'Deseja realmente excluir o canteiro?',
      name: 'telaEditarCanteiroAlertDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroAlertEscolha1 {
    return Intl.message(
      'Não',
      name: 'telaEditarCanteiroAlertEscolha1',
      desc: '',
      args: [],
    );
  }

  String get telaEditarCanteiroAlertEscolha2 {
    return Intl.message(
      'Sim',
      name: 'telaEditarCanteiroAlertEscolha2',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginTitulo {
    return Intl.message(
      'Crie uma \nnova conta',
      name: 'telaCadastrarLoginTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginDescricao {
    return Intl.message(
      'Preencha os campos abaixo e crie sua conta na Agrofate.',
      name: 'telaCadastrarLoginDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginNome {
    return Intl.message(
      'Nome',
      name: 'telaCadastrarLoginNome',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginEmail {
    return Intl.message(
      'Email',
      name: 'telaCadastrarLoginEmail',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginSenha {
    return Intl.message(
      'Senha',
      name: 'telaCadastrarLoginSenha',
      desc: '',
      args: [],
    );
  }

  String get telaCadastrarLoginBotao {
    return Intl.message(
      'CADASTRAR',
      name: 'telaCadastrarLoginBotao',
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

  String get telaLoginCampoSenha {
    return Intl.message(
      'Senha',
      name: 'telaLoginCampoSenha',
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

  String get telaConfigAlterarEmail {
    return Intl.message(
      'Alterar e-mail',
      name: 'telaConfigAlterarEmail',
      desc: '',
      args: [],
    );
  }

  String get telaConfigAlterarSenha {
    return Intl.message(
      'Alterar senha',
      name: 'telaConfigAlterarSenha',
      desc: '',
      args: [],
    );
  }

  String get telaConfigSobre {
    return Intl.message(
      'Sobre a Agrofate',
      name: 'telaConfigSobre',
      desc: '',
      args: [],
    );
  }

  String get telaConfigPolitica {
    return Intl.message(
      'Políticas de privacidade',
      name: 'telaConfigPolitica',
      desc: '',
      args: [],
    );
  }

  String get telaConfigSair {
    return Intl.message(
      'Sair',
      name: 'telaConfigSair',
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

  String get telaDadosTitulo {
    return Intl.message(
      'Dados',
      name: 'telaDadosTitulo',
      desc: '',
      args: [],
    );
  }

  String get telaDadosUmidadeDescricao {
    return Intl.message(
      'Importante para a formação',
      name: 'telaDadosUmidadeDescricao',
      desc: '',
      args: [],
    );
  }

  String get telaDadosUmidadeDescricao2 {
    return Intl.message(
      'adequada das plantas',
      name: 'telaDadosUmidadeDescricao2',
      desc: '',
      args: [],
    );
  }

  String get telaDadosPHDescricao {
    return Intl.message(
      'Indicador de fertilidade',
      name: 'telaDadosPHDescricao',
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

  String get telaDadosStatusPH1 {
    return Intl.message(
      'Ácido',
      name: 'telaDadosStatusPH1',
      desc: '',
      args: [],
    );
  }

  String get telaDadosStatusPH2 {
    return Intl.message(
      'Alcalino',
      name: 'telaDadosStatusPH2',
      desc: '',
      args: [],
    );
  }

  String get telaDadosNotificationMessage1 {
    return Intl.message(
      'O nível de pH está fora do intervalo certo. \nÉ indicado acrescentar mais fertilizante.',
      name: 'telaDadosNotificationMessage1',
      desc: '',
      args: [],
    );
  }

  String get telaDadosNotificationMessage2 {
    return Intl.message(
      'O nível de pH está dentro do intervalo certo! \nMantenha a quantidade de fertilizante.',
      name: 'telaDadosNotificationMessage2',
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

  String get telaDadosAs {
    return Intl.message(
      ' às ',
      name: 'telaDadosAs',
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