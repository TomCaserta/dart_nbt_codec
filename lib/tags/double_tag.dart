part of nbt_codec;

class DoubleTag extends Tag {
  double data;
  
  DoubleTag(String name,[double this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeDouble(data);
  }
  
  void load (DataInput dis) {
    data = dis.readDouble();
  }
  
  int get ID => TagType.TAG_Double;
  
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  Tag copy () {
    return new DoubleTag(name, data);
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
      DoubleTag o = other;
      return data == o.data;
    }
    return false;
  }
}