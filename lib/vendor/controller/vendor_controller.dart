import 'package:image_picker/image_picker.dart';

class VendorController {
  pickStoreImage(ImageSource source) async {
    final ImagePicker _pickImage = ImagePicker();

    XFile? _file = await _pickImage.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Iamge Selected');
    }
  }
}
