part of nbt_codec;

List<int> gLongStr (String longVal, {Endianness endian: Endianness.BIG_ENDIAN}) {
  if (endian == Endianness.BIG_ENDIAN) {
    return Int64.parseInt(longVal).toBytes().reversed.toList();
  }
  else return Int64.parseInt(longVal).toBytes();
}

List<int> gLong (int int32, {Endianness endian: Endianness.BIG_ENDIAN}) {
  if (endian == Endianness.BIG_ENDIAN) {
  return new Int64.fromInts(0, int32).toBytes().reversed.toList();
  }
  else return new Int64.fromInts(0, int32).toBytes();
  
}


class LongTag extends Tag {
  List<int> data;
  
  LongTag (String name, [List<int> this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeLong(data);
  }

  void load (DataInput dis) {
    data = dis.readLong();
  }
  
  int get ID => TagType.TAG_Long;

  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  Tag copy () {
    return new LongTag (name, data);
  }
  
  Int64 getLong ({Endianness endian: Endianness.BIG_ENDIAN}) {
    if (endian == Endianness.BIG_ENDIAN) {
      return new Int64.fromBytesBigEndian(data);
    }
    else {
      return new Int64.fromBytes(data);
    }
  }
  
  String getHex ({Endianness endian: Endianness.BIG_ENDIAN}) {
    if (endian == Endianness.BIG_ENDIAN) {
      return new Int64.fromBytesBigEndian(data).toHexString();
    }
    else {
      return new Int64.fromBytes(data).toHexString();
    }
  }
  
  String getStr ({Endianness endian: Endianness.BIG_ENDIAN}) {
    if (endian == Endianness.BIG_ENDIAN) {
      return new Int64.fromBytesBigEndian(data).toString();
    }
    else {
      return new Int64.fromBytes(data).toString();
    }
  }
  
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   hb.add(data);
   return hb.getHash();   
  }
  
  operator == (dynamic other) {
    if (super == other) {
      LongTag o = other;
      return const ListEquality().equals(data,o.data);
    }
    return false;
  }
}