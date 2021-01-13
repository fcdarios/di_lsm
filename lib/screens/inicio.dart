import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Color color_fondo = Colors.white;
  Color color_secundario = Colors.grey[800];
  Color color_primario = Colors.indigo[100];


  @override
  Widget build(BuildContext context) {
    String _texto_des = "Reconocimiento LSM es una aplicacion que reconoce las letras del lenguaje de señas mexicano mediante la camara.";
    String _ins1 = "1. Al entrar a la aplicación dar click en start\n";
    String _ins2 = "2. Colocar la mano de la persona centrada en la vista de la camara\n";
    String _ins3 = "3. Al entrar a la interfaz de la camara dar click en el boton de play para iniciar el reconocimiento.\n";
    String _ins4 = "4. La camara tomara una foto cada 3 segundos.\n";
    String _ins5 = "5. Al terminar de capturar las imagenes dar en el boton de pausa.\n";
    String _texto_ins = _ins1 + _ins2 + _ins3 + _ins4 + _ins5;
    double dr_tam_titulo = 18;
    double dr_tam_texto = 16;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_fondo,
        elevation: 0,        
        iconTheme: IconThemeData(color: color_secundario),
      ),
      body: Container(
        color: color_fondo,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Image.asset('assets/icono.png')
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Reconocimiento LSM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: color_secundario,
                    fontFamily: "Amatic_SC",
                  ),
                ),
              )
            ),
            Expanded(
              flex: 6,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: RaisedButton(
                    color: color_primario,
                    onPressed: () => {Navigator.pushNamed(context, '/camara')},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "start",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 80,
                            color: color_secundario,
                            fontFamily: "Amatic_SC",
                          ),
                        )
                      ),
                    ),
                  )
                ),
              )
            ),
          ],
        )
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: color_primario,
            elevation: 0,        
            iconTheme: IconThemeData(color: color_secundario),
            title: Text(
              "Ayuda", 
              style: TextStyle(
                color: color_secundario,
                fontFamily: "Amatic_SC",
                fontSize: 35
                )
              ),
            centerTitle: true,
          ),
          body: Container(
            color: color_fondo,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Descripción",
                          style: TextStyle(
                            fontSize: dr_tam_titulo,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          _texto_des,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: dr_tam_texto,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Text(
                          "Instrucciones",
                          style: TextStyle(
                            fontSize: dr_tam_titulo,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          _texto_ins,
                          
                          style: TextStyle(
                            fontSize: dr_tam_texto,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Acerca de:",
                          style: TextStyle(
                            fontSize: dr_tam_titulo,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Mares Cupa Ana Paulina\nMedina Reyes Alejandro\nOlivare Flores José Darío",
                          style: TextStyle(
                            fontSize: dr_tam_texto,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  

}
