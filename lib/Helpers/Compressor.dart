// // ignore_for_file: prefer_const_constructors

// import 'package:image_compression_flutter/image_compression_flutter.dart';

// class Compressor {
// //static

//   static void compress(
//       {required ImageFile input,
//       required Function(ImageFile) onSucc,
//       required Function(dynamic) onFailed}) async {
//     Configuration config = Configuration(
//       outputType: ImageOutputType.jpg,
//       useJpgPngNativeCompressor: false,
//       quality: 40, //0-100
//     );
//     final param = ImageFileConfiguration(input: input, config: config);
//     try {
//       final output = await compressor.compress(param);
//       print("Input size : ${input.sizeInBytes}");
//       print("Output size : ${output.sizeInBytes}");
//       onSucc(output);
//     } catch (e) {
//       onFailed(e);
//     }
//   }
// }
