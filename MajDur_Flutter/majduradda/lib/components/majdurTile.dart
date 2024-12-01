import 'package:flutter/material.dart';
import 'package:majduradda/models/Majdurs/majdurdetails.dart';

class MajdurTile extends StatelessWidget{
  final MajdurDetails? majdur;
  const MajdurTile({
    super.key,
    required this.majdur, 
    });

  @override
  Widget build(BuildContext context){
    return Container(
      decoration:  BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12)
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration:  BoxDecoration(
              color:Colors.white, 
              borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(25),
            child:  const Icon(Icons.person,size: 100,)
            ),
        ),

         const SizedBox(height: 25,),

        Text(
          majdur!.firstName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          ),

          const SizedBox(height: 25,),


        Text(majdur!.id,style: const TextStyle(color:Colors.grey),),
                  const SizedBox(height: 10,),
        Text(majdur!.majdurType,style:const TextStyle(color:Colors.grey)),

        const SizedBox(height: 60,),

        Row(
            children: [
              majdur!.availability
                        ? const Icon(Icons.online_prediction, color: Colors.green)
                        : const Icon(Icons.offline_bolt, color: Colors.red),
                    Text(
                      majdur!.availability ? "Available" : "Unavailable",
                      style: TextStyle(
                        color: majdur!.availability ? Colors.green : Colors.red,
                      ),
                    ),
            ],
          ),
        ],
       )
      ]
      ),
    );
  }
}