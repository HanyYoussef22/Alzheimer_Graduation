import 'package:lottie/lottie.dart';
import 'package:alzahimer/shard/network/remote/datdbase/database_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'imageDetiles.dart';

class ShowHistory extends StatelessWidget {
  static const String RouteName = '/image_list_screen';

  @override
  Widget build(BuildContext context) {
    var User = FirebaseAuth.instance.currentUser;
    final String userId =
        User!.uid; // Replace with the user ID you want to display images for

    return Scaffold(
      body:OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
         if(connected)
         {
           return StreamBuilder<DocumentSnapshot>(
               stream: DataBaseUtil.readUserFromFirStoreStrem(userId),
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                 final List<dynamic> imageUrlList = snapshot.data!['listimageurl'];
                 return ListView.builder(
                   itemCount: snapshot.data!.exists ? imageUrlList.length : 0,
                   itemBuilder: (context, index) {
                     if (snapshot.data!.exists) {
                       final url = imageUrlList[index];
                       return FutureBuilder<bool>(
                         future: checkImageURL(url),
                         builder: (BuildContext context,
                             AsyncSnapshot<bool> snapshot) {
                           return Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Container(
                               decoration: BoxDecoration(
                                 border: Border.all(
                                     color: Colors.purple,
                                     width: 2
                                 ),
// shape: BoxShape.circle,
                                 borderRadius: BorderRadius.circular(15),
                               ),

                               child: Card(
                                 shadowColor: Colors.black,
                                 child: GestureDetector(
                                   onTap: () {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (_) =>
                                             ImageDetailsScreen(
                                               imageUrl: url,
                                             ),
                                       ),
                                     );
                                   },
                                   child: Slidable(
                                     startActionPane: ActionPane(

                                       extentRatio: 0.50,
                                       motion: StretchMotion(),
                                       children: [
                                         SlidableAction(
                                           onPressed: (context) {
// DataBaseUtil.updateImagesForDelete(index: index, userId: userId);
// DataBaseUtil.deleteImage(imageUrl: url, userId: userId);

                                           },
                                           icon: Icons.delete,
                                           backgroundColor: Theme
                                               .of(context)
                                               .colorScheme
                                               .error,
                                           label: 'Delete',
                                           borderRadius: BorderRadius.circular(15),
                                           autoClose: true,
                                         )
                                       ],
                                     ),
                                     child: ClipRect(
                                         child: Align(
                                             alignment: Alignment.topCenter,
                                             heightFactor: 0.40,
                                             child: Image.network(
                                               url ??
                                                   'https://firebasestorage.googleapis.com/v0/b/alzahimer-ac621.appspot.com/o/userImages%2FHo4P7O6njFVW3h2rwkqi3MqlYKs1.png?alt=media&token=82b5873e-3b9e-4d22-886f-e102a08280b9',
                                               fit: BoxFit.cover,
                                             ))),
                                   ),
                                 ),
                               ),
                             ),
                           );
                         },
                       );
                     } else {
                       return SizedBox
                           .shrink(); // Return an empty widget if the document doesn't exist
                     }
                   },
                 );
               },
             );
         }
         else
         {
           return Center(child: Lottie.asset('assets/55.json'));
         }
        },child: Center(),

      ),

    );
  }

  Future<bool> checkImageURL(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return true;
    }
  }
}


