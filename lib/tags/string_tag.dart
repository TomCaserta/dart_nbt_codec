part of nbt_codec;

class StringTag extends Tag {
  String data;
  
  StringTag (String name, [String this.data]):super(name) {
    if (data != null && data.isEmpty) {
      throw new ArgumentError("Empty string not allowed");
    }
  }
  
  void write (DataOutput dos) {
    dos.writeUTF(data);
  }
  
  void load (DataInput dis) {
    data = dis.readUTF();
  }
  
  int get ID => Tag.TAG_String;
  
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  Tag copy () {
    return new StringTag (name, data);
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
      StringTag o = other;
      return o.data == data;
    }
    return false;
  }
}