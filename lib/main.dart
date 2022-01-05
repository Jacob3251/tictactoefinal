//@dart=2.9
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List _matrix = <List>[
  //    List.filled(3, (_)=> null),
  //    List.filled(3, (_)=> null),
  //    List.filled(3, (_)=> null),
  //   ];
  Color col;
  List<List> rows= [];

  _HomePageState() {
    for (int i = 0; i < 3; i++) {
      List<String> row = [];
      row.add(' ');
      row.add(' ');
      row.add(' ');
      rows.add(row);
    }

  }
  initMatrix(){
    for(int i =0;i<3;i++){
      for(int j =0;j<3;j++){
        rows[i][j]=' ';
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Tic - Tac - Toe',style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),),
          centerTitle: true,
          
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red,Colors.red.shade200,Colors.yellow,Colors.red.shade200,Colors.red],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://images.pexels.com/photos/776654/pexels-photo-776654.jpeg?cs=srgb&dl=pexels-ylanite-koppens-776654.jpg&fm=jpg'),
              fit: BoxFit.cover
            )
            //color: Colors.blue
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer(0,0),
                    buildContainer(0,1),
                    buildContainer(0,2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer(1,0),
                    buildContainer(1,1),
                    buildContainer(1,2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer(2,0),
                    buildContainer(2,1),
                    buildContainer(2,2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String lastchar = 'O';

  GestureDetector buildContainer(int i, int j) {

    return GestureDetector(
      onTap: (){

          changematrix(i, j);

          if(_checkdraw()){
            _showDialog(null);
          }else{
            checkwinner(i, j);
          }


      },
      child: Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.withOpacity(.3),
                      //image: DecorationImage(image: NetworkImage('https://thumbs.dreamstime.com/z/seamless-pattern-colored-board-game-attributes-suitable-wallpaper-wrapping-textile-seamless-pattern-colored-board-145839806.jpg'),fit: BoxFit.fill),
                      border: Border.all(color: Colors.white54,width: 5)
                    ),
                    child: Center(child: Text(rows[i][j],style: TextStyle(fontSize: 58,color: Colors.white),)),
                  ),
    );
  }

  void changematrix(int i, int j) {
    setState(() {
      if(rows[i][j]==' '){
        if(lastchar == 'O')rows[i][j]='X';
        else rows[i][j]='O';

        lastchar = rows[i][j];

      }
    });
  }

  void checkwinner(int x,int y){
    var col=0,row=0,diag=0,rdiag=0;
    var n = rows.length-1;
    var player = rows[x][y];
    for(int i = 0;i<rows.length;i++){
      if(rows[x][i]== player)col++;
      if(rows[i][y]== player)row++;
      if(rows[i][i]== player)diag++;
      if(rows[i][n-1]== player)rdiag++;
    }
    if (row == n+1 || col == n+1 || diag == n+1 || rdiag == n+1) {
      _showDialog(player);
    }
  }
  bool _checkdraw(){
    var draw = true;
    rows.forEach((i) {
      i.forEach((j) {
        if(j==' ')
          draw = false;
      });
    });
    return draw;
  }
  void _showDialog(String winner) {
    String text;
    if(winner == null){
      text= "It's a draw";
    }
    else{
      text = "Player ${winner} has won";
    }
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: Text('Game Finished'),
        content: Text(text),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
            setState(() {
              initMatrix();
            });
          },
              child: Text('Restart Game'))
        ],
      );
    });
  }
}




