import 'package:flutter/material.dart';
import 'package:helping_hands_app/demo_workers.dart';
import 'package:helping_hands_app/widget/Worker.dart';
import '../widget/base_ui.dart';
class WorkerScreen extends StatelessWidget {
  static String workerscreen='/workerscreen';
  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final id=routeArgs['id'];
    final title=routeArgs['title'];
    final assetImage=routeArgs['assetImage'];
    return Hero(
      tag: "animation",
          child: Scaffold(
            
        appBar: AppBar(
        //title: Text(title),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
         
        ),
        
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                child: Container(),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white

                )
                
              ),
              Positioned(child:
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0)),
                    child: Image(image: AssetImage(assetImage))),
                    SizedBox(height:10.0),
                    
                       Expanded(
                                                child: ListView.builder(
                          itemCount: Demo_Worker.length,
                          itemBuilder: (ctx,index)=>Worker(
                            name:Demo_Worker[index].name,
                            rating:Demo_Worker[index].rating,
                            image:Demo_Worker[index].image
                            
                          )),
                       ),
                    
                ],
              ),
              )
            ],
          ),
        ),
          )
    
      
       
        
        );
  }
}
