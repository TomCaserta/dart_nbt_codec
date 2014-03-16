library nbt_codec;

import "io/data.dart";
import "package:fixnum/fixnum.dart";
import "package:collection/equality.dart";
import "dart:convert";
import "dart:typed_data";
import "hashbuilder/hashbuilder.dart";

part 'tags/tag.dart';
part 'tags/byte_array_tag.dart';
part 'tags/byte_tag.dart';
part 'tags/compound_tag.dart';
part 'tags/double_tag.dart';
part 'tags/end_tag.dart';
part 'tags/float_tag.dart';
part 'tags/int_array_tag.dart';
part 'tags/int_tag.dart';
part 'tags/list_tag.dart';
part 'tags/long_tag.dart';
part 'tags/short_tag.dart';
part 'tags/string_tag.dart';

class CompressionType {
  final int t;
  const CompressionType (this.t);
  static const CompressionType NONE = const CompressionType(0);
  static const CompressionType Z_LIB = const CompressionType(1);
  static const CompressionType G_ZIP = const CompressionType(2);
}

Tag readNBT (dynamic byteData, { CompressionType compressionType: CompressionType.NONE }) {
  if (byteData is! Uint8List && byteData is! List) throw new ArgumentError("[byteData] must be either Uint8List or List<int>");
  DataInput inputData;
  if (compressionType == CompressionType.NONE){
    Uint8List bData;
    if (byteData is! Uint8List) {
      bData = new Uint8List.fromList(byteData);  
    }
    else {
      bData = byteData;
    }
    inputData = new DataInput.fromUint8List(bData);
  }
  else if (compressionType == CompressionType.Z_LIB) {
    inputData = new DataInput.fromZLib(byteData);
  }
  else if (compressionType == CompressionType.G_ZIP) {
    inputData = new DataInput.fromGZip(byteData);
  }
  else throw new UnsupportedError("Compression type unknown");
  print(inputData.data);
  return Tag.readNamedTag(inputData);
}

List<int> writeNBT (Tag tag) {
  DataOutput dos = new DataOutput();
  Tag.writeNamedTag(tag, dos);
  return dos.getBytes();
}