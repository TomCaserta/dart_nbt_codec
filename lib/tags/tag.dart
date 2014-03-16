part of nbt_codec;

// TO/DO: Remove once all methods are implemented
//@proxy
abstract class Tag {
  static const int TAG_End = 0x00;
  static const int TAG_Byte = 0x01;
  static const int TAG_Short = 0x02;
  static const int TAG_Int = 0x03;
  static const int TAG_Long = 0x04;
  static const int TAG_Float = 0x05;
  static const int TAG_Double = 0x06;
  static const int TAG_Byte_Array = 0x07;
  static const int TAG_String = 0x08;
  static const int TAG_List = 0x09;
  static const int TAG_Compound = 0x0A;
  static const int TAG_Int_Array = 0x0B;
  
  String _name;
  int get ID;
  
  void write(DataOutput dos);
  void load (DataInput dis);
  
  String toString() {
    return JSON.encode(toJson());
  }
  
  Tag (String this._name) {
    if (this._name == null) this._name = "";
  }
  
  Map toJson () {
    return { "TAG_Type_Name": getTagName(ID), "ID": ID, "name": name };
  }
  
  operator ==(dynamic other) {
    if (other == null || !(other is Tag)) {
      return false;
    }
    Tag o = other;
    if (ID != o.ID) {
      return false;
    }
    if (_name == null && o._name != null || _name != null && o._name == null) {
      return false;
    }
    if (_name != null && _name != o._name) {
      return false;
    }
    return true;
  }
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   return hb.getHash();   
  }
  
  set name (String name) {
    if (name == null) {
      _name = "";
    }
    else {
      _name = name;
    }
  }
  
  String get name => _name;
  
  static Tag readNamedTag (DataInput dis) {
    int type = dis.readByte();
    if (type == Tag.TAG_End) {
      return new EndTag();
    }
    
    String name = dis.readUTF();
    Tag tag = newTag (type, name);
    if (tag == null) throw new Exception("Tag is null. Cannot read any further. Type: $type Name: $name");
    tag.load(dis);
    return tag;
  }
  
  static writeNamedTag (Tag tag, DataOutput dos) {
    dos.writeByte(tag.ID);
    if (tag.ID == Tag.TAG_End) return;
    dos.writeUTF(tag.name);
    tag.write(dos);
  }  
  
  static Tag newTag (int type, String name) {
    switch (type) {
      case TAG_End:
        return new EndTag();
      case TAG_Byte:
        return new ByteTag(name);
      case TAG_Short:
        return new ShortTag(name);
      case TAG_Int:
        return new IntTag(name);
      case TAG_Long: 
        return new LongTag(name);
      case TAG_Float:
        return new FloatTag(name);
      case TAG_Double:
        return new DoubleTag(name);
      case TAG_Byte_Array:
        return new ByteArrayTag(name);
      case TAG_Int_Array:
        return new IntArrayTag(name);
      case TAG_String:
        return new StringTag(name);
      case TAG_List:
        return new ListTag<Tag>(name);
      case TAG_Compound:
        return new CompoundTag(name);
    }
    return null;
  }
  
  static String getTagName (int type) {
    switch (type) {
      case TAG_End:
        return "TAG_End";
      case TAG_Byte:
        return "TAG_Byte";
      case TAG_Short:
        return "TAG_Short";
      case TAG_Int:
        return "TAG_Int";
      case TAG_Long: 
        return "TAG_Long";
      case TAG_Float:
        return "TAG_Float";
      case TAG_Double:
        return "TAG_Double";
      case TAG_Byte_Array:
        return "TAG_Byte_Array";
      case TAG_Int_Array:
        return "TAG_Int_Array";
      case TAG_String:
        return "TAG_String";
      case TAG_List:
        return "TAG_List";
      case TAG_Compound:
        return "TAG_Compound";
    }
    return "UNKNOWN";
  }
  
  Tag copy();
}