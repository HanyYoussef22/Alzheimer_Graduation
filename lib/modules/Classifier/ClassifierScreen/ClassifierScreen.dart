import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img; // added import for ImageByteFormat
import 'dart:typed_data';

import 'package:alzahimer/Base.dart';
import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/modules/Classifier/ClassifierScreen/ClassifierNavigetor.dart';
import 'package:alzahimer/modules/Classifier/ClassifierScreen/ClassifierViewModel.dart';
import 'package:alzahimer/shard/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tflite/tflite.dart';

import 'package:path_provider/path_provider.dart';
import '../../../shard/styles/clors.dart';
import '../ResuiltScreen/ResultScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'loadingScreen/Loading.dart';

class ClassifierScreen extends StatefulWidget {
  static const String roudeName = '/';

  @override
  State<ClassifierScreen> createState() => _ClassifierScreenState();
}

class _ClassifierScreenState
    extends BaseState<ClassifierScreen, ClassifierViewModel>
    implements ClassifierNavigetor {
  int currentIndex = 0;
  List? _outputs;
  File? _image;
  bool _loading = false;
  String? url;
  late File selectedImage;
  late File selectedImagee;

  @override
  void initState() {
    super.initState();
    viewModel.navigetor = this;
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  ClassifierViewModel iniViewModel() {
    return ClassifierViewModel();
  }

  final ImagePicker _picker = ImagePicker();
  final controllerr = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controllerr,
      child: Scaffold(
        body: _loading
            ? Loading()
            : Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null
                          ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset('assets/3.json'),
                      ),
                      Text(
                        'Uploude Image',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(20),
                              color: PrimaryColor),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: WhiteColor,
                              ),
                                          Text('Uploude Image',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.normal,
                                                  color: WhiteColor))
                                        ],
                                      ),
                                    ),
                                  )
                                ])
                          : result1(_image!, _outputs),

                      _image == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: defaultButton(
                                btnColor: PrimaryColor,
                                radius: 15,
                                text: 'save result to the Gallery',
                                onPressed: () async {
                                  final imageee =
                      await controllerr.captureFromWidget(
                          result1(_image!, _outputs));
                      if (imageee == null) return;
                      await save(imageee);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _image == null
                    ? Container()
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultButton(
                    btnColor: PrimaryColor,
                    radius: 15,
                    text: 'save result to the Cloud',
                    onPressed: () async {
                      final imageee =
                                      await controllerr.captureFromWidget(
                                          result1(_image!, _outputs));
                                  if (imageee == null) return;
                                  // await save(imageee);

                                  await uploadImage(imageee);
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      // _image == null
                      //     ? Container()
                      //     : const Text(
                      //   ' Warning: this result may not accurate so you need to consulting a doctor as soon as possible(The accuracy of the results is 91%)',
                      //   style: TextStyle(color: Colors.red, fontSize: 20),
                      // ),
                    ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = selectedImage = File(image.path);
    });
    Future.delayed(const Duration(seconds: 5))
        .then((value) => classifyImage(File(image.path)));
  }

  // to get image from gallery
  Widget result1(File image, List? outputs) {
    return ResultScreen(image, outputs);
  }

  Future<String> save(Uint8List bytes) async {
    await [Permission.storage].request();
    final name = 'result of Xray';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filepath'];
  } // to save the result to gallery

  Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: 0.2,
        imageMean: 0.0,
        imageStd: 180.0,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  } // to classify the image and return the output

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  void showScreenAndAwait() async {
    await Future.delayed(const Duration(seconds: 20));
    Lottie.asset('assets/1.json');

    print('2 seconds have passed!');
  }

  Future<void> uploadImage(Uint8List imageBytes) async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;

    // Create a unique file name based on the current timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '$id-$timestamp.png';

    // Convert the Uint8List to an Image
    final image = await decodeImageFromList(imageBytes);

    // Create a new file in temporary directory and write the image bytes to it
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/$fileName').create();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    await file.writeAsBytes(bytes!.buffer.asUint8List());

    // Upload the file to Firebase Storage
    final ref = FirebaseStorage.instance.ref('$id/$fileName');
    await ref.putFile(file);

    // Get the download URL and update the user's profile
    final url = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection(MyUser.CollecationName)
        .doc(id)
        .update({
      'listimageurl': FieldValue.arrayUnion([url]),
    });
  }

// uploudeimage(){
//   // var ref= FirebaseFirestore.instance.ref('images/');
//
// }

// Future<void> uploadImage(Uint8List imageBytes) async {
//   final user = FirebaseAuth.instance.currentUser;
//   final id = user!.uid;
//
//   // Convert the Uint8List to an Image
//   final image = await decodeImageFromList(imageBytes);
//
//   // Create a new file in temporary directory and write the image bytes to it
//   final tempDir = await getTemporaryDirectory();
//   final file = await new File('${tempDir.path}/$id.png').create();
//   final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
//   await file.writeAsBytes(bytes!.buffer.asUint8List());
//
//   // Upload the file to Firebase Storage
//   final ref = FirebaseStorage.instance.ref('userImages/$id.png');
//   await ref.putFile(file);
//
//   // Get the download URL and update the user's profile
//   final url = await ref.getDownloadURL();
//   await FirebaseFirestore.instance.collection(MyUser.CollecationName).doc(id).update({
//     'imageurl': url,
//   });
// }
}
