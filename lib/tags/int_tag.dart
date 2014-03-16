part of nbt_codec;

class IntTag extends Tag {
  int data;
  
  IntTag (String name, [int this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeInt(data);
  }
  
  void load (DataInput dis) {
    data = dis.readInt();
  }
  
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  int get ID => Tag.TAG_Int;
  
  Tag copy () {
    return new IntTag(name, data);
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
      IntTag o = other;
      return o.data == data;
    }
    return false;
  }
}