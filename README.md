Dart NBT Codec
==============
[![Build Status](https://drone.io/github.com/TomCaserta/dart_nbt_codec/status.png)](https://drone.io/github.com/TomCaserta/dart_nbt_codec/latest)

This library for Dart allows you to read and write NBT structures, you can also supply the compression type to deflate the nbt data.

The libraries provides an example inside the example directory. The tests files also contains an example for loading nbt data via the browser.

Example Usage
=============

First import the nbt codec (and io if you are using serverside file loading):

```Dart
import "package:nbt_codec/nbt_codec.dart";
```

Then in your main load in an NBT file

```Dart
void main () {
  File f = new File("level.dat");
  CompoundTag tag = readNBT(f.readAsBytesSync(), compressionType: CompressionType.G_ZIP);
  print(tag);
}
```

This will output a json serialized representation of your level.dat nbt data.

Read the documentation to find out how to further manipulate the NBT Data


TODO
====

- Better examples
- Better hashCode handling
- Check that Int64 is handled correctly on dart2js
- Implement the Java modified version of readUTF for UTF8 Strings

