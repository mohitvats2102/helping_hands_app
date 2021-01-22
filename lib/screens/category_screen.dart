import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/Widget/GridViewFileFrame.dart';
import 'package:helping_hands_app/demo_examples.dart';
import 'package:helping_hands_app/module/GridViewFile.dart';
import 'package:helping_hands_app/screens/login_screen.dart';
class  CategoryScreen extends StatelessWidget {
   final FirebaseAuth _auth = FirebaseAuth.instance;

  static String categoryScreen = '/categoryScreen';
  final  Function changetheme;
 CategoryScreen(this.changetheme);
  @override
 // _CategoryScreenState createState() => _CategoryScreenState();
//}

//class _CategoryScreenState extends State<CategoryScreen> {
  void logout(BuildContext ctx)
  {
    _auth.signOut();
    Navigator.of(ctx).pushReplacementNamed(LoginScreen.loginScreen);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Ctaegories"),
        
           actions: [   
                     
                     DropdownButtonHideUnderline(
                      child: DropdownButton(
              
                      icon: Icon(Icons.more_vert), 
                      items: [
                        
                          DropdownMenuItem(
                          value: "Theme",
                          child: Text("Theme")),
                          DropdownMenuItem(value:"Logout",child: Text("Logout"))
                              ],
                      onChanged: (itemIdentifier)
                      {
                         if(itemIdentifier=='Theme')
                         {
                              changetheme();
                         }
                         if(itemIdentifier=='Logout')
                         {
                               logout(context);
                         }
                      },),)],
      
      ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0,horizontal:10.0),
            child: GridView(
        children:Demo_Example
              .map(
                (catData) => GridViewFileFrame(
              catData.id,
              catData.title,
              catData.color,
            ),
        )
              .toList(),
        gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent
        (maxCrossAxisExtent: 200,childAspectRatio: 2/2,
         crossAxisSpacing: 20,
        mainAxisSpacing: 50,) ,

      ),
          ),
    );
  }
}
