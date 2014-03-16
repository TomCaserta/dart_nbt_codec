part of nbt_codec;

// TODO: Think about possibility of making lists growable for ease of use

class IntArrayTag extends Tag {
  List<int> data;
  
  IntArrayTag (String name, [List<int> this.data]):super(name);
  
  void write (DataOutput dos) {
    dos.writeInt(data.length);
    for (int i = 0; i < data.length; i++) {
      dos.writeInt(data[i]);
    }
  }
  
  Map toJson () {
    return super.toJson()..addAll({ "data": data });
  }
  
  void load (DataInput dis) {
    int length = dis.readInt();
    data = new List<int>(length);
    for (int i = 0; i < length; i++) {
      data[i] = dis.readInt();
    }
  }
  
  int get ID => Tag.TAG_Int_Array;
   
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   hb.add(data);
   return hb.getHash();   
  }
  
  operator == (dynamic other) {
    if (super == other) {
      IntArrayTag o = other;
      return ((data == null && o.data == null) || (data != null && const ListEquality().equals(data, o.data)));
    }
    return false;
  }
  
  Tag copy () {
    List copiedList = new List<int>.from(data, growable: false);
    return new IntArrayTag(name, this.data);
  }
  
}