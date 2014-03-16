part of nbt_codec;

class ByteArrayTag extends Tag {
  List<int> data;
  
  ByteArrayTag (String name, [List<int> this.data]):super(name);
 
  void write (DataOutput dos) {
    dos.writeInt(data.length);
    dos.write(data);
  }
  
  void load (DataInput dis) {
    int length = dis.readInt();
    data = new List<int>(length);
    dis.readFully(data);
  }
  
  int get ID => TagType.TAG_Byte_Array;
  
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
      ByteArrayTag o = other;
      return const ListEquality().equals(data, o.data);
    }
    return false;
  }
  
  Tag copy () {
    List<int> copiedData = new List<int>.from(data, growable: false);
    return new ByteArrayTag (name, copiedData);
  }
}