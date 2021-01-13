import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:di_lenguaje_smx/models/settings.dart';
import 'package:di_lenguaje_smx/widgets/wSettings.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  bool _modo_pro = false;

  var images = []; // Tipo File
  Image img_preview; // Vista previa de la imagen
  int num_images = 0; // Contador de imagenes tomadas
  bool _play = false;
  int _segundos = 2;
  int _contador = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: cameraPreview(),
            ),
            Align(
              alignment: Alignment.center,
              child: _play ? Text(
                _contador.toString(),
                style: TextStyle(
                  color: Colors.white30,
                  fontSize: 200,
                  fontWeight: FontWeight.bold
                ),
              ) : null,
            ),
            Positioned(
              top: 30,
              right: 10,
              child: IconButton(
                  icon: new Icon(Icons.settings, color: Colors.white60, size: 24,),
                  onPressed: _showDialog,
              )
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 135,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          _play ? 
                            "Presiona pausa para terminar el reconocimiento":
                            "Presiona play para iniciar el reconocimiento",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                            "Aqui va el texto",
                          style: TextStyle(
                            color: Colors.white12,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: new BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10))),
                        child: images.length == 0 ? null : img_preview,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: cameraControl(context),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          height: 50,
                          width: 50,
                          child: Center(
                              child: Text(
                            num_images.toString(),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() async { // Todo esto hace que se muestre el recuadro de ajustes
  
    final Settings settings = await showDialog<Settings>(
      context: context,
      builder: (context) => WSettings(modo_pro: _modo_pro),
    );
    if (settings != null) {
      setState(() {
        _modo_pro = settings.modo_pro;
      });
    }
  }

  void _clickPlay(context) {
    // if (_play) {
    //   setState(() {
    //     _play = false;
    //   });
    // } else {
    //   setState(() {
    //     _play = true;
    //   });
    //   _timer_play();
    // }
  }

  void _timer_play() async {
    setState(() {
      images = []; // Tipo File
      num_images = 0;
    });

    while (_play) { // Se siguen capturando imagenes hasta que se ponga ponga pause   
      setState(() {
       _contador = _segundos + 1 ;
      });
      for (var i = 0; i < _segundos + 1; i++) {
        setState(() {
          _contador--;
        });
        if(_play)
          if(_contador != 0) 
            await Future.delayed(Duration(milliseconds: 1000));
          else {
            onCapture(context);
            await Future.delayed(Duration(milliseconds: 1000));
          }
      }   
    }
  }

  Widget cameraControl(context) {
    return FloatingActionButton(
      child: Icon(
        _play ? Icons.pause : Icons.play_arrow,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        _clickPlay(context);
      },
    );
  }

  onCapture(context) async {
    try {
      await cameraController.takePicture().then((value) async {
        File file = new File(value.path);
        print("--------------------");
        print(file.path);
        setState(() {
          images.add(file);
          img_preview = Image.file(file);
          num_images++;
        });
      });
    } catch (e) {
      showCameraException(e);
    }
  }

  /// Display camera preview
  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Cargando...',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }
    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }
}
