part of nbt_codec;

class LongTag extends Tag {
  Int64 data;
  
  LongTag (String name, [Int64 this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeLong(data);
  }

  void load (DataInput dis) {
    data = dis.readLong();
  }
  
  int get ID => Tag.TAG_Long;

  Map toJson () {
    return super.toJson()..addAll({ "data": data.toInt() });
  }
  
  Tag copy () {
    return new LongTag (name, data);
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
      return data == o.data;
    }
    return false;
  }
}