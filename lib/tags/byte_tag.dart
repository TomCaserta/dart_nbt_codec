part of nbt_codec;

class ByteTag extends Tag {
  int data;
  
  ByteTag (String name, [int this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeByte(data);
  }
  
  void load (DataInput dis) {
    data = dis.readByte();
  }
  
  int get ID => Tag.TAG_Byte;
   
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   hb.add(data);
   return hb.getHash();   
  }
  
  operator ==(dynamic other) {
    if (super == other) {
      ByteTag o = other;
      return data == o.data;
    }
    return false;
  }
  Tag copy () {
    return new ByteTag(name, data);
  }

}