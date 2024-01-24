import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceRequestType {
  Icon serviceIcon;
  String title;
  bool selected;

  ServiceRequestType(
      {required this.serviceIcon, required this.title, required this.selected});
}

List<ServiceRequestType> serviceRequestTypes = [
  ServiceRequestType(
      serviceIcon: Icon(Icons.flash_on),
      title: "Solução de problemas tecnicos",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.accessibility),
      title: "Marcação de visita para solução de problema tecnico",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.accessibility),
      title: "Duvidas sobre utilização de algum produto ou serviço",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.cancel),
      title: "Cancelamento de pedido",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.refresh),
      title: "Alteração de pedido",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.accessibility),
      title: "Redirecionamento para todos os setores da empresa",
      selected: false),
  ServiceRequestType(
      serviceIcon: Icon(Icons.arrow_forward),
      title: "Informações sobre produtos ou serviços",
      selected: false),
];

class ContactType {
  Icon serviceIcon;
  String title;

  ContactType({required this.serviceIcon, required this.title});
}

List<ContactType> contactsTypes = [
  ContactType(
    serviceIcon: Icon(FontAwesomeIcons.whatsapp),
    title: "Whatsapp",
  ),
  ContactType(
    serviceIcon: Icon(FontAwesomeIcons.instagram),
    title: "Instagram",
  ),
  ContactType(
    serviceIcon: Icon(FontAwesomeIcons.sms),
    title: "SMS (mensagem de texto)",
  ),
  ContactType(
    serviceIcon: Icon(Icons.phone),
    title: "Ligação",
  ),
  ContactType(
    serviceIcon: Icon(Icons.email),
    title: "Email",
  ),
];
