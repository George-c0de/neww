import 'dart:async';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


// class ImagePicker extends StatefulWidget {
//   const ImagePicker({ Key? key }) : super(key: key);

//   @override
//   _ImagePickerState createState() => _ImagePickerState();
// }

// class _ImagePickerState extends State<ImagePicker> {

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
//   late PickedFile _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   void _pickImage() async {
//     try {
//       final pickedFile = await _picker.getImage(source: ImageSource.gallery);
//       setState(() {
//         _imageFile = pickedFile;
//       });
//     } catch (e) {
//       print("Image picker error " + e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }






enum SingingCharacter { lafayette, jefferson }
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 35,
          width: 400,
          child:RadioListTile<SingingCharacter>(
            contentPadding: EdgeInsets.all(0),
            activeColor: Color(0xffA0130C),
            title: const Text('Сообщить о проблеме'),
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          )
        ),
        RadioListTile<SingingCharacter>(
          contentPadding: EdgeInsets.all(0),
          title: const Text('Предложить улучшение'),
          value: SingingCharacter.jefferson,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
            });
          },
        ),
      ],
    );
  }
}



class CalbackPage extends StatelessWidget {
  Function fo = (){};
  CalbackPage({ Key? key, required this.fo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  ListView(
          scrollDirection: Axis.vertical,
          children: [
            Align(alignment: Alignment.topRight,child: InkWell(
              child: InkWell(child:Container(
                decoration: BoxDecoration(
                  color:Color(0xffFFEED1),
                  borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                padding: EdgeInsets.only(left:7,right:7,top:7,bottom:7),
                margin: EdgeInsets.only(right: 10,top:10),
                child: SvgPicture.asset(
                  'assets/images/arrowleft.svg',
                  semanticsLabel : 'A red up arrow',
                  width : 18,
                  fit : BoxFit.cover
                ),
              ),
            ),
            onTap: (){
              fo();
            },
            ),
            ),
            Padding(padding: EdgeInsets.only(left:20,right:20,top:20,bottom:10),child:Text('Обратная связь',style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xff272727),fontSize: 30))),
            Padding(padding: EdgeInsets.only(left:20,right:20,bottom:5),child: Text('Здесь вы можете оставить отзыв или пожелание. Также при необходимости прикрепить фото.',style: TextStyle(fontSize:14,color:Color(0xff272727),height: 1.5)),),
            Padding(padding: EdgeInsets.only(left:13,right:20),child: MyStatefulWidget()),
            Padding(padding: EdgeInsets.only(left:20,top:10),child: Text('Ответ будет отправлен на вашу почту',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.all(7.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                  ),
                  isDense: true,
                  hintText: 'Ваш e-mail',
                  filled: true,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left:20,right:20,top:10),child: Text('Расскажите, что случилось',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                maxLines: 8,
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(),
                //   hintText: 'Опишите вашу проблему',
                // ),
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Color(0xffFFEED1),
                  contentPadding: EdgeInsets.all(7.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C),width: 1)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffA0130C), width: 1),
                  ),
                  isDense: true,
                  hintText: 'Опишите вашу проблему',
                  filled: true,
                ),

              ),
            ),
            Container(margin: EdgeInsets.symmetric(horizontal: 20),child:MyHomePage(),),
            // Container(child: Text('Отправить'),),
            Wrap(children: [  Container(
            margin: const EdgeInsets.only(left:20.0,right:20,top:25),
            padding: const EdgeInsets.only(top:7,bottom:7,left: 20,right:20),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffA0130C),
              borderRadius: BorderRadius.all(Radius.circular(40))
            ),
            child: InkWell(child: Text('Отправить',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
              onTap: (){
                fo();
              },
            )
          ),],)

          ]
        // )
      // )
    );
  }

}







// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Image Picker Demo',
//       home: MyHomePage(title: 'Image Picker Example'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          label: 'image_picker_example_picked_images',
          child: SizedBox(
              width: 200,
              height:400,
              child:  ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),));
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewVideo();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [ 
      //     Center(
      //   child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      //       ? FutureBuilder<void>(
      //           future: retrieveLostData(),
      //           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      //             switch (snapshot.connectionState) {
      //               case ConnectionState.none:
      //               case ConnectionState.waiting:
      //                 return const Text(
      //                   'You have not yet picked an image.',
      //                   textAlign: TextAlign.center,
      //                 );
      //               case ConnectionState.done:
      //                 return _handlePreview();
      //               default:
      //                 if (snapshot.hasError) {
      //                   return Text(
      //                     'Pick image/video error: ${snapshot.error}}',
      //                     textAlign: TextAlign.center,
      //                   );
      //                 } else {
      //                   return const Text(
      //                     'You have not yet picked an image.',
      //                     textAlign: TextAlign.center,
      //                   );
      //                 }
      //             }
      //           },
      //         )
      //       : _handlePreview(),
      // ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Semantics(
          //   label: 'image_picker_example_from_gallery',
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       isVideo = false;
          //       _onImageButtonPressed(ImageSource.gallery, context: context);
          //     },
          //     heroTag: 'image0',
          //     tooltip: 'Pick Image from gallery',
          //     child: const Icon(Icons.photo),
          //   ),
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                
                padding: const EdgeInsets.only(top: 16.0),
                child: InkWell(
                  onTap: () {
                    isVideo = false;
                    _onImageButtonPressed(
                      ImageSource.gallery,
                      context: context,
                      isMultiImage: true,
                    );
                  },
                  // heroTag: 'image1',
                  // tooltip: 'Pick Multiple Image from gallery',
                  child:  Container(
                    padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Color(0xffA0130C),width: 1.5,style: BorderStyle.solid)
                    ),
                    child:Text('Прикрепить фото',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xffA0130C)),)
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                margin: EdgeInsets.only(top:8),
                child: Text('Можно загрузить до 10 файлов.\nРазмер каждого не должен \nпревышать 5 мб.',style: TextStyle(color: Color(0xff939393),fontSize: 10),),
              )
            ],
          )
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       isVideo = false;
          //       _onImageButtonPressed(ImageSource.camera, context: context);
          //     },
          //     heroTag: 'image2',
          //     tooltip: 'Take a Photo',
          //     child: const Icon(Icons.camera_alt),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.red,
          //     onPressed: () {
          //       isVideo = true;
          //       _onImageButtonPressed(ImageSource.gallery);
          //     },
          //     heroTag: 'video0',
          //     tooltip: 'Pick Video from gallery',
          //     child: const Icon(Icons.video_library),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.red,
          //     onPressed: () {
          //       isVideo = true;
          //       _onImageButtonPressed(ImageSource.camera);
          //     },
          //     heroTag: 'video1',
          //     tooltip: 'Take a Video',
          //     child: const Icon(Icons.videocam),
          //   ),
          // ),
        ],
      ),
        ]
      // )
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
