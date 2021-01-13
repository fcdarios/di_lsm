import 'package:flutter/material.dart';
import 'package:di_lenguaje_smx/models/settings.dart';

class WSettings extends StatefulWidget {
  final bool modo_pro;

  const WSettings({Key key, this.modo_pro}) : super(key: key);

  @override
  _WSettingsState createState() => _WSettingsState();
}

class _WSettingsState extends State<WSettings> {
  double _segundos;
  String _txtSegundos;
  bool _modo_pro;
  Color color_fondo = Colors.white;
  Color color_secundario = Colors.grey[800];
  Color color_primario = Colors.indigo[100];

  @override
  void initState() {
    super.initState();
    _modo_pro = widget.modo_pro;
  }

  void _onChange (bool value){
    setState(() {
      _modo_pro = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal : 40, vertical : MediaQuery.of(context).size.height * 0.34),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.indigo[50],
        child: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,                
                 child: Container(
                   margin: EdgeInsets.only(top: 15),
                   child: Text(
                    'Configuración',
                      style: TextStyle(
                      color: color_secundario,
                      fontSize: 35,
                      fontFamily: 'Amatic_SC',
                    ),
                ),
                 ),
              ),
              Align(
                alignment: Alignment.center,
                 child: Container(
                   width: MediaQuery.of(context).size.longestSide,
                   height: MediaQuery.of(context).size.height * 0.15,
                   child: Column(
                     children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Modo filtro',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Amatic_SC',
                                ),
                              ),
                              Switch(
                                activeColor: Colors.indigo[200],
                                inactiveThumbColor: color_secundario,
                                value: _modo_pro, 
                                onChanged: _onChange
                              )
                            ],
                          )
                        ),
                     ],
                   ),
                 )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        highlightColor: color_primario,
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: Text("Cancelar",
                          style: TextStyle(
                            color: color_secundario,
                            fontSize: 30,
                            fontFamily: 'Amatic_SC'
                          ),
                        )
                      ),
                      FlatButton(
                        highlightColor: color_primario,
                        onPressed:_setPreferencias, 
                        child: Text("Aceptar",
                          style: TextStyle(
                            color: color_secundario,
                            fontSize: 30,
                            fontFamily: 'Amatic_SC'
                          ),
                        )
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

    _setPreferencias() async{
    Settings settings = new Settings(_modo_pro);
    Navigator.pop(context, settings);
  }
}