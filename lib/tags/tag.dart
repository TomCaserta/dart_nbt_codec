part of nbt_codec;

abstract class Tag {
  
  String _name;
  
  /// Gets the tag type for this tag
  int get ID;
  
  Tag (String this._name) {
    if (this._name == null) this._name = "";
  }
  
  /***
   * Writes the Tag data to the DataOutput [dos]
   */
  void write(DataOutput dos);
  
  /***
   * Loads the Tag data from the DataInput [dis]
   */
  void load (DataInput dis);
  
  /***
   * Encodes the object and returns a json string
   */
  String toString() {
    return JSON.encode(toJson());
  }
    
  /***
   * Converts the Tag object to a json encodable map
   */
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
  
  /***
   * Sets the tag name
   */
  set name (String name) {
    if (name == null) {
      _name = "";
    }
    else {
      _name = name;
    }
  }
  
  /***
   * Gets the tag name
   */
  String get name => _name;
  
  /***
   * Read a named tag (Most likely CompoundTag) from the DataInput [dis]
   * and returns the tag.
   */
  static Tag readNamedTag (DataInput dis) {
    int type = dis.readByte();
    if (type == TagType.TAG_End) {
      return new EndTag();
    }
    
    String name = dis.readUTF();
    Tag tag = newTag (type, name);
    if (tag == null) throw new Exception("Tag is null. Cannot read any further. Type: $type Name: $name");
    tag.load(dis);
    return tag;
  }
  
  /***
   * Writes the named tag to the DataOutput [dos]
   */
  static writeNamedTag (Tag tag, DataOutput dos) {
    dos.writeByte(tag.ID);
    if (tag.ID == TagType.TAG_End) return;
    dos.writeUTF(tag.name);
    tag.write(dos);
  }  
  
  /*** 
   * Creates a new tag from the TagType [type] and given [name]
   */
  static Tag newTag (int type, String name) {
    switch (type) {
      case TagType.TAG_End:
        return new EndTag();
      case TagType.TAG_Byte:
        return new ByteTag(name);
      case TagType.TAG_Short:
        return new ShortTag(name);
      case TagType.TAG_Int:
        return new IntTag(name);
      case TagType.TAG_Long: 
        return new LongTag(name);
      case TagType.TAG_Float:
        return new FloatTag(name);
      case TagType.TAG_Double:
        return new DoubleTag(name);
      case TagType.TAG_Byte_Array:
        return new ByteArrayTag(name);
      case TagType.TAG_Int_Array:
        return new IntArrayTag(name);
      case TagType.TAG_String:
        return new StringTag(name);
      case TagType.TAG_List:
        return new ListTag(name);
      case TagType.TAG_Compound:
        return new CompoundTag(name);
    }
    return null;
  }
  
  /***
   * Converts the given TagType [type] to the string representation
   */
  static String getTagName (int type) {
    switch (type) {
      case TagType.TAG_End:
        return "TAG_End";
      case TagType.TAG_Byte:
        return "TAG_Byte";
      case TagType.TAG_Short:
        return "TAG_Short";
      case TagType.TAG_Int:
        return "TAG_Int";
      case TagType.TAG_Long: 
        return "TAG_Long";
      case TagType.TAG_Float:
        return "TAG_Float";
      case TagType.TAG_Double:
        return "TAG_Double";
      case TagType.TAG_Byte_Array:
        return "TAG_Byte_Array";
      case TagType.TAG_Int_Array:
        return "TAG_Int_Array";
      case TagType.TAG_String:
        return "TAG_String";
      case TagType.TAG_List:
        return "TAG_List";
      case TagType.TAG_Compound:
        return "TAG_Compound";
    }
    return "UNKNOWN";
  }
  
  static Type getType (int type) {
    switch (type) {
      case TagType.TAG_End:
        return EndTag;
      case TagType.TAG_Byte:
        return ByteTag;
      case TagType.TAG_Short:
        return ShortTag;
      case TagType.TAG_Int:
        return IntTag;
      case TagType.TAG_Long: 
        return LongTag;
      case TagType.TAG_Float:
        return FloatTag;
      case TagType.TAG_Double:
        return DoubleTag;
      case TagType.TAG_Byte_Array:
        return ByteArrayTag;
      case TagType.TAG_Int_Array:
        return IntArrayTag;
      case TagType.TAG_String:
        return StringTag;
      case TagType.TAG_List:
        return ListTag;
      case TagType.TAG_Compound:
        return CompoundTag;
    }
    return Tag;
  }
  
  /***
   * Copies [this] and returns a new Tag
   * Tag is not the same tag in memory as [this]
   */
  Tag copy();
}