import 'package:flutter/material.dart';
import 'package:miventa_app/models/models.dart';

const kButtonHeight = 50.0;
const kColorButtonCal = Color(0xFF223C78);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Digite el nombre de un pdv',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const kLargeButtonText = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const List<Color> markerColors = [
  Color.fromRGBO(10, 38, 71, 1),
  Color.fromRGBO(20, 66, 114, 1),
  Color.fromRGBO(32, 82, 149, 1),
  Color.fromRGBO(44, 116, 179, 1),
  Color.fromRGBO(130, 170, 227, 1),
  Color.fromRGBO(145, 216, 228, 1),
  Color.fromRGBO(28, 49, 94, 1),
  Color.fromRGBO(34, 124, 112, 1),
  Color.fromRGBO(136, 164, 124, 1),
  Color.fromRGBO(29, 28, 229, 1),
  Color.fromRGBO(70, 73, 255, 1),
  Color.fromRGBO(121, 120, 255, 1),
  Color.fromRGBO(255, 225, 93, 1),
];

List<String> departamentos = [
  'ATLANTIDA',
  'CHOLUTECA',
  'COLON',
  'COMAYAGUA',
  'COPAN',
  'CORTES',
  'EL PARAISO',
  'FRANCISCO MORAZAN',
  'GRACIAS A DIOS',
  'INTIBUCA',
  'ISLAS DE LA BAHIA',
  'LA PAZ',
  'LEMPIRA',
  'OCOTEPEQUE',
  'OLANCHO',
  'SANTA BARBARA',
  'VALLE',
  'YORO',
];

List<Municipio> municipios = const <Municipio>[
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'ARIZONA',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'EL PORVENIR',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'ESPARTA',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'JUTIAPA',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'LA CEIBA',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'LA MASICA',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'SAN FRANCISCO',
  ),
  Municipio(
    departamento: 'ATLANTIDA',
    municipio: 'TELA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'APACILAGUA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'CHOLUTECA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'CONCEPCIÓN DE MARÍA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'DUYURE',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'EL CORPUS',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'EL TRIUNFO',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'MARCOVIA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'MOROLICA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'NAMASIGÜE',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'OROCUINA',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'PESPIRE',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'SAN ANTONIO DE FLORES',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'SAN ISIDRO',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'SAN JOSÉ',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'SAN MARCOS DE COLÓN',
  ),
  Municipio(
    departamento: 'CHOLUTECA',
    municipio: 'SANTA ANA DE YUSGUARE',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'BALFATE',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'BONITO ORIENTAL',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'IRIONA',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'LIMÓN',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'SABÁ',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'SANTA FE',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'SANTA ROSA DE AGUÁN',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'SONAGUERA',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'TOCOA',
  ),
  Municipio(
    departamento: 'COLON',
    municipio: 'TRUJILLO',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'AJUTERIQUE',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'COMAYAGUA',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'EL ROSARIO',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'ESQUÍAS',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'HUMUYA',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'LA LIBERTAD',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'LA TRINIDAD',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'LAJAS',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'LAMANÍ',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'LEJAMANÍ',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'MEÁMBAR',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'MINAS DE ORO',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'OJO DE AGUA',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SAN JERÓNIMO',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SAN JOSÉ DE COMAYAGUA',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SAN JOSÉ DEL POTRERO',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SAN LUIS',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SAN SEBASTIÁN',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'SIGUATEPEQUE',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'TAULABE',
  ),
  Municipio(
    departamento: 'COMAYAGUA',
    municipio: 'VILLA DE SAN ANTONIO',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'CABAÑAS',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'CONCEPCIÓN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'COPÁN RUINAS',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'CORQUÍN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'CUCUYAGUA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'DOLORES',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'DULCE NOMBRE',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'EL PARAÍSO',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'FLORIDA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'LA JIGUA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'LA UNIÓN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'NUEVA ARCADIA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN AGUSTÍN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN ANTONIO',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN JERÓNIMO',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN JOSÉ',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN JUAN DE OPOA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN NICOLÁS',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SAN PEDRO',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SANTA RITA',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'SANTA ROSA DE COPÁN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'TRINIDAD DE COPÁN',
  ),
  Municipio(
    departamento: 'COPAN',
    municipio: 'VERACRUZ',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'CHOLOMA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'COFRADIA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'LA LIMA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'OMOA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'PIMIENTA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'POTRERILLOS',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'PUERTO CORTÉS',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'SAN ANTONIO DE CORTÉS',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'SAN FRANCISCO DE YOJOA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'SAN MANUEL',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'SAN PEDRO SULA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'SANTA CRUZ DE YOJOA',
  ),
  Municipio(
    departamento: 'CORTES',
    municipio: 'VILLANUEVA',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'ALAUCA',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'DANLÍ',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'EL PARAÍSO',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'GÜINOPE',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'JACALEAPA',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'LIURE',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'MOROCELÍ',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'OROPOLÍ',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'POTRERILLOS',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'SAN ANTONIO DE FLORES',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'SAN LUCAS',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'SAN MATÍAS',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'SOLEDAD',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'TEUPASENTI',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'TEXIGUAT',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'TROJES',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'VADO ANCHO',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'YAUYUPE',
  ),
  Municipio(
    departamento: 'EL PARAISO',
    municipio: 'YUSCARÁN',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'ALUBARÉN',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'CEDROS',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'CURARÉN',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'EL PORVENIR',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'GUAIMACA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'LA LIBERTAD',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'LA VENTA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'LEPATERIQUE',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'MARAITA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'MARALE',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'NUEVA ARMENIA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'OJOJONA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'ORICA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'REITOCA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SABANAGRANDE',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SAN ANTONIO DE ORIENTE',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SAN BUENAVENTURA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SAN IGNACIO',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SAN JUAN DE FLORES',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SAN MIGUELITO',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SANTA ANA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'SANTA LUCIA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'TALANGA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'TATUMBLA',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'TEGUCIGALPA D.C.',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'VALLE DE ÁNGELES',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'VALLECILLO',
  ),
  Municipio(
    departamento: 'FRANCISCO MORAZAN',
    municipio: 'VILLA DE SAN FRANCISCO',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'AHUAS',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'BRUS LAGUNA',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'JUAN FRANCISCO BULNES',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'PUERTO LEMPIRA',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'VILLEDA MORALES',
  ),
  Municipio(
    departamento: 'GRACIAS A DIOS',
    municipio: 'WAMPURSIRPE',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'CAMASCA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'COLOMONCAGUA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'CONCEPCIÓN',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'DOLORES',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'INTIBUCÁ',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'JESÚS DE OTORO',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'LA ESPERANZA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'MAGDALENA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'MASAGUARA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN ANTONIO',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN FRANCISCO OPALACA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN ISIDRO',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN JUAN DE FLORES',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN MARCOS DE LA SIERRA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SAN MIGUEL GUANCAPLA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'SANTA LUCÍA',
  ),
  Municipio(
    departamento: 'INTIBUCA',
    municipio: 'YAMARANGUILA',
  ),
  Municipio(
    departamento: 'ISLAS DE LA BAHIA',
    municipio: 'GUANAJA',
  ),
  Municipio(
    departamento: 'ISLAS DE LA BAHIA',
    municipio: 'JOSÉ SANTOS GUARDIOLA',
  ),
  Municipio(
    departamento: 'ISLAS DE LA BAHIA',
    municipio: 'ROATÁN',
  ),
  Municipio(
    departamento: 'ISLAS DE LA BAHIA',
    municipio: 'UTILA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'AGUANQUETERIQUE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'CABAÑAS',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'CANE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'CHINACLA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'GUAJIQUIRO',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'LA PAZ',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'LAUTERIQUE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'MARCALA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'MERCEDES DE ORIENTE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'OPATORO',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SAN ANTONIO DEL NORTE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SAN JOSÉ',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SAN JUAN',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SAN PEDRO DE TUTULE',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SANTA ANA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SANTA ELENA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SANTA MARÍA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'SANTIAGO PURINGLA',
  ),
  Municipio(
    departamento: 'LA PAZ',
    municipio: 'YARULA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'BELÉN',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'CANDELARIA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'COLOLACA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'ERANDIQUE',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'GRACIAS',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'GUALCINSE',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'GUARITA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LA CAMPA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LA IGUALA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LA UNIÓN',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LA VIRTUD',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LAS FLORES',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'LEPAERA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'MAPULACA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'PIRAERA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN ANDRÉS',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN FRANCISCO',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN JUAN GUARITA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN MANUEL COLOHETE',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN MARCOS DE CAIQUÍN',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN RAFAEL',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SAN SEBASTIÁN',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'SANTA CRUZ',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'TALGUA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'TAMBLA',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'TOMALÁ',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'VALLADOLID',
  ),
  Municipio(
    departamento: 'LEMPIRA',
    municipio: 'VIRGINIA',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'BELÉN GUALCHO',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'CONCEPCIÓN',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'DOLORES MERENDÓN',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'FRATERNIDAD',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'LA ENCARNACIÓN',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'LA LABOR',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'LUCERNA',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'MERCEDES',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'NUEVA OCOTEPEQUE',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SAN FERNANDO',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SAN FRANCISCO DEL VALLE',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SAN JORGE',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SAN MARCOS',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SANTA FE',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SENSENTI',
  ),
  Municipio(
    departamento: 'OCOTEPEQUE',
    municipio: 'SINUAPA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'CAMPAMENTO',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'CATACAMAS',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'CONCORDIA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'DULCE NOMBRE DE CULMI',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'EL ROSARIO',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'ESQUIPULAS DEL NORTE',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'FROYLAN TURCIOS',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'GUALACO',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'GUARIZAMA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'GUATA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'GUAYAPE',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'JANO',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'JUTICALPA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'LA UNIÓN',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'MANGULILE',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'MANTO',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SALAMÁ',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SAN ESTEBAN',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SAN FRANCISCO DE BECERRA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SAN FRANCISCO DE LA PAZ',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SANTA MARÍA DEL REAL',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'SILCA',
  ),
  Municipio(
    departamento: 'OLANCHO',
    municipio: 'YOCÓN',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'ARADA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'ATIMA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'AZACUALPA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'CEGUACA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'CHINDA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'COLINAS',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'CONCEPCIÓN DEL NORTE',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'CONCEPCIÓN DEL SUR',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'EL NÍSPERO',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'GUALALA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'ILAMA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'LAS VEGAS',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'MACUELIZO',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'NARANJITO',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'NUEVA CELILAC',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'NUEVA FRONTERA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'PETOA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'PROTECCIÓN',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'QUIMISTÁN',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN FRANCISCO DE OJUERA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN LUIS',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN MARCOS',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN NICOLÁS',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN PEDRO ZACAPA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SAN VICENTE CENTENARIO',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SANTA BÁRBARA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'SANTA RITA',
  ),
  Municipio(
    departamento: 'SANTA BARBARA',
    municipio: 'TRINIDAD',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'ALIANZA',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'AMAPALA',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'ARAMECINA',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'CARIDAD',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'GOASCORÁN',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'LANGUE',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'NACAOME',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'SAN FRANCISCO DE CORAY',
  ),
  Municipio(
    departamento: 'VALLE',
    municipio: 'SAN LORENZO',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'ARENAL',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'EL NEGRITO',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'EL PROGRESO',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'JOCÓN',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'MORAZÁN',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'OLANCHITO',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'SANTA RITA',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'SULACO',
  ),
  Municipio(
    departamento: 'YORO',
    municipio: 'VICTORIA',
  ),
];

List<Ambiente> ambientes = const <Ambiente>[
  Ambiente(
    tipo: 'CALLE',
    descripcion: 'OTRO',
  ),
  Ambiente(
    tipo: 'CALLE',
    descripcion: 'TRÁFICO DENSO',
  ),
  Ambiente(
    tipo: 'CALLE',
    descripcion: 'TRÁFICO LIGERO',
  ),
  Ambiente(
    tipo: 'CALLE',
    descripcion: 'TRÁFICO MODERADO',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'ADOBE',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'BLOQUE',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'LADRILLO',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'MADERA',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'METAL',
  ),
  Ambiente(
    tipo: 'CASA',
    descripcion: 'OTRO',
  ),
  Ambiente(
    tipo: 'EDIFICIO',
    descripcion: '1 A 3 PISOS',
  ),
  Ambiente(
    tipo: 'EDIFICIO',
    descripcion: '4 A 5 PISOS',
  ),
  Ambiente(
    tipo: 'EDIFICIO',
    descripcion: '5 O MÁS PISOS',
  ),
  Ambiente(
    tipo: 'EDIFICIO',
    descripcion: 'OTRO',
  ),
  Ambiente(
    tipo: 'MONTAÑA',
    descripcion: 'NINGUNO',
  ),
  Ambiente(
    tipo: 'PARQUE',
    descripcion: 'ALTA CONCURRENCIA',
  ),
  Ambiente(
    tipo: 'PARQUE',
    descripcion: 'BAJA CONCURRENCA',
  ),
  Ambiente(
    tipo: 'PARQUE',
    descripcion: 'MODERADA CONCURRENCIA',
  ),
  Ambiente(
    tipo: 'PARQUE',
    descripcion: 'OTRO',
  ),
];
