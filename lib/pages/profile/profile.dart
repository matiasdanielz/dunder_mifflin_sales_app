import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_5/pages/homepage/homepage.dart';
import 'package:flutter_application_5/pages/sidebar/sidebar.dart';
import 'package:flutter_application_5/requests/requests.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  File? _selectedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _biographyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final Map<String, dynamic> userData = await Requests().getUserDetails();

      setState(() {
        print(_nameController);

        _nameController.text = userData['name'];
        _emailController.text = userData['emailAdress'];
        _biographyController.text = userData['biography'];

        print(_nameController);

        if (userData['profilePicture'] != null) {
          _selectedImage = File(userData['userPhoto']);
        }
      });
    } catch (e) {
      print('Erro ao carregar os detalhes do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Perfil",
        ),
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
            icon: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Column(
            children: [
              Container(
                height: 115,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: _selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              )
                            : Image(
                                image: AssetImage(
                                  "Assets/images/dwight.jpeg",
                                ),
                              ),
                      ),
                    ),
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
                          builder: (BuildContext context) => pickPhotoSheet(),
                        );
                      },
                      child: const Text("Editar Foto"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  labelText: 'Nome Completo',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Segoe',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  labelText: 'E-mail',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Segoe',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                minLines: 7,
                maxLines: 7,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  labelText: 'Biografia (opcional)',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Segoe',
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) => saveSheet());
                },
                child: Container(
                  decoration: const BoxDecoration(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Salvar",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget saveSheet() => Container(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Alteração de e-mail",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "O e-mail de acesso ao aplicativo foi alterado para mail@mail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
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
                    "Confirmar",
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
                    Navigator.pop(
                      context,
                    )
                  },
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      "Cancelar",
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
                "Edições não salvas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Ao fechar, as edições feitas serão perdidas. Deseja Continuar ?",
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
                  Navigator.pop(
                    context,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SideBarPage(),
                      ),
                    )
                  },
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      "Continuar",
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

  Widget pickPhotoSheet() => Container(
        width: double.infinity,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 15.0,
            right: 15.0,
          ),
          child: ListView(
            children: [
              const Icon(
                Icons.drag_handle,
                color: Colors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                onTap: () async {
                  await _pickImageFromGallery();
                },
                leading: const Icon(
                  Icons.image,
                ),
                title: const Text(
                  "Escolher na biblioteca",
                ),
              ),
              ListTile(
                onTap: () async {
                  await _pickImageFromCamera();
                },
                leading: Icon(
                  Icons.camera_alt,
                ),
                title: Text(
                  "Tirar foto",
                ),
              ),
              ListTile(
                onTap: () {
                  _removeUserPhoto();
                },
                iconColor: Color.fromARGB(255, 177, 21, 21),
                textColor: Color.fromARGB(255, 177, 21, 21),
                leading: Icon(
                  Icons.delete,
                ),
                title: Text(
                  "Remover foto atual",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });

    return;
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });

    return;
  }

  _removeUserPhoto() async {
    ByteData data = await rootBundle.load('Assets/images/avatar.jpeg');
    List<int> bytes = data.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/avatar_temp.jpeg');
    await tempFile.writeAsBytes(bytes);

    setState(() {
      _selectedImage = tempFile;
    });
  }
}
