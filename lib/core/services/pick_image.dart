// import 'package:image_picker/image_picker.dart';

// Future imgFromGallery() async {
//   final ImagePicker picker = ImagePicker();

//   final pickedFile = await picker.pickMultiImage(imageQuality: 50);

//   photo = pickedFile.map((e) => File(e.path)).toList();
//   allPhotos += photo;
//   photo.clear();
// }

// Future videoFromGallery() async {
//   XFile xFile;
//   final pickedFile = await picker.pickVideo(
//     source: ImageSource.gallery,
//   );

//   print(pickedFile?.path);
//   if (pickedFile != null) {
//     allPhotos.add(pickedFile);
//   } else {
//     print('No file selected.');
//   }
//   notifyListeners();
// }

// Future oneImgFromGallery() async {
//   try {
//     final pickedFile =
//         await picker.pickImage(imageQuality: 50, source: ImageSource.gallery);

//     if (pickedFile != null) {
//       allPhotos.add(File(pickedFile.path));
//     } else {
//       print('No image selected.');
//     }
//   } on Exception catch (e) {
//     print(e);
//     // TODO
//   }
//   notifyListeners();
// }
