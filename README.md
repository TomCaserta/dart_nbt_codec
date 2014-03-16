Dart NBT Codec
==============
[![Build Status](https://drone.io/github.com/TomCaserta/dart_nbt_codec/status.png)](https://drone.io/github.com/TomCaserta/dart_nbt_codec/latest)

This library for Dart allows you to read and write NBT structures, you can also supply the compression type to deflate the nbt data.

The libraries provides an example inside the example directory. The tests files also contains an example for loading nbt data via the browser.


*Documentation*:  http://tom.caserta.co.uk/documentation/nbt_codec/index.html

Long Tags
=========

As this is a bit tricky I felt it deserved its own heading. At the moment due to javascript not being able to handle Int64 values LongTags output as the byte representation.

What this means is, to write and read Long tags you need to provide: a list of 8 bytes and the endianness (default Big Endian as java + minecraft is big endian).

I have exposed a few helper functions for converting Strings courtesy of Int64 package "fixnum". 

```gLongStr(String value) // Returns an Int64 representation of [value]

```gLong(int int32val) // Returns an Int64 representation of an int 32 value.

LongTag has .getHex() .getLong() and .getString() methods too.

If anyone can think of a better way to handle this limitation please open an issue on github.


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

