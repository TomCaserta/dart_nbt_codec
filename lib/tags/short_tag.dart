part of nbt_codec;

class ShortTag extends Tag {
  int data;
  
  ShortTag (String name, [int this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeShort(data);
  }
  
  void load (DataInput dis) {
    this.data = dis.readShort();
  }
  
  int get ID => TagType.TAG_Short;
  
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  Tag copy () {
    return new ShortTag(name, data);
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
      ShortTag o = other;
      return o.data == data;
    }
    return false;
  }
}