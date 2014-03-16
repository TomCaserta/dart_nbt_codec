part of nbt_codec;

class FloatTag extends Tag {
  double data;
  
  FloatTag (String name, [double this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeFloat(data);
  }
  
  void load (DataInput dis) {
    data = dis.readFloat();
  }
  
  int get ID => TagType.TAG_Float;
  
  Tag copy () {
    return new FloatTag (name, data);
  }
  
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
      FloatTag o = other;
      return data == o.data;
    }
    return false;
  }
}