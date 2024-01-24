import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/homepage/homepage.dart';
import 'package:flutter_application_5/pages/serviceRequest/serviceRequestRepository.dart';

class ServiceRequestModel {
  Set<ServiceRequestType> selectedServiceTypes = {};
  Set<ContactType> selectedContactTypes = {};
}

class ServiceRequest extends StatefulWidget {
  @override
  _ServiceRequest createState() => _ServiceRequest();
}

class _ServiceRequest extends State<ServiceRequest> {
  int currentPage = 1;
  ServiceRequestModel requestModel = ServiceRequestModel();

  void nextPage() {
    if (currentPage < 3) {
      setState(() {
        currentPage++;
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentBody;
    switch (currentPage) {
      case 1:
        currentBody = ServiceRequestReason(
          model: requestModel,
          onNextPage: nextPage,
        );
        break;
      case 2:
        currentBody = ServiceRequestExplanation(
          model: requestModel,
          onNextPage: nextPage,
          onPreviousPage: previousPage,
        );
        break;
      case 3:
        currentBody = ServiceRequestContact(
          model: requestModel,
          onPreviousPage: previousPage,
        );
        break;
      default:
        currentBody = Container();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("Solicitação de atendimento"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (BuildContext context) => unsavedChangesSheet(),
              );
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: currentBody,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage == 1)
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) => unsavedChangesSheet(),
                    );
                  },
                  child: Text(
                    "Cancelar",
                  ),
                ),
              if (currentPage > 1)
                TextButton(
                  onPressed: previousPage,
                  child: Text("Voltar"),
                ),
              if (currentPage > 2)
                Container(
                  width: 110,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF305DA8),
                  ),
                  child: TextButton(
                    onPressed: nextPage,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        Text(
                          "Enviar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF305DA8),
                  ),
                  child: IconButton(
                    onPressed: nextPage,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget unsavedChangesSheet() => Container(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Cancelar Solicitação",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "A solicitação ainda não foi criada. Ao cancelar, voce perderá os dados informados. Deseja cancelar ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  )
                },
                child: Container(
                  decoration: const BoxDecoration(),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      "Continuar Solicitação",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class ServiceRequestReason extends StatefulWidget {
  final ServiceRequestModel model;
  final VoidCallback onNextPage;

  ServiceRequestReason({
    required this.model,
    required this.onNextPage,
  });

  @override
  _ServiceRequestReasonState createState() => _ServiceRequestReasonState();
}

class _ServiceRequestReasonState extends State<ServiceRequestReason> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Text(
            "Qual o motivo do atendimento ?",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          flex: 3,
          child: ListView.separated(
            itemCount: serviceRequestTypes.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
              );
            },
            itemBuilder: (context, index) {
              final ServiceRequestType itemData = serviceRequestTypes[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    if (widget.model.selectedServiceTypes.contains(itemData)) {
                      widget.model.selectedServiceTypes.remove(itemData);
                    } else {
                      widget.model.selectedServiceTypes.add(itemData);
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 65,
                  color: widget.model.selectedServiceTypes.contains(itemData)
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(itemData.title),
                    tileColor: Colors.transparent,
                    leading: itemData.serviceIcon,
                    trailing:
                        widget.model.selectedServiceTypes.contains(itemData)
                            ? Icon(Icons.check)
                            : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ServiceRequestExplanation extends StatelessWidget {
  final ServiceRequestModel model;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  ServiceRequestExplanation({
    required this.model,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Explique o que aconteceu:",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: const TextField(
              minLines: 7,
              maxLines: 7,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                labelText: 'Descrição da situação',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Segoe',
                ),
                alignLabelWithHint: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceRequestContact extends StatefulWidget {
  final ServiceRequestModel model;
  final VoidCallback onPreviousPage;

  ServiceRequestContact({
    required this.model,
    required this.onPreviousPage,
  });

  @override
  _ServiceRequestContactState createState() => _ServiceRequestContactState();
}

class _ServiceRequestContactState extends State<ServiceRequestContact> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Text(
            "Qual a melhor forma para entrarmos em contato com você?",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: contactsTypes.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
              );
            },
            itemBuilder: (context, index) {
              final ContactType itemData = contactsTypes[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    if (widget.model.selectedContactTypes.contains(itemData)) {
                      widget.model.selectedContactTypes.remove(itemData);
                    } else {
                      widget.model.selectedContactTypes.add(itemData);
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  color: widget.model.selectedContactTypes.contains(itemData)
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  child: ListTile(
                    leading: itemData.serviceIcon,
                    title: Text(
                      itemData.title,
                    ),
                    trailing:
                        widget.model.selectedContactTypes.contains(itemData)
                            ? Icon(Icons.check)
                            : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
