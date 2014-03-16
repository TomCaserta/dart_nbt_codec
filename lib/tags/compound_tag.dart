part of nbt_codec;

class CompoundTag extends Tag {
  Map<String, Tag> _tags = new Map<String, Tag>();
  
  CompoundTag([String name]):super(name);
  
  void write (DataOutput dos) {
    for (Tag tag in _tags.values) {
      Tag.writeNamedTag(tag, dos);
    }
    dos.writeByte(TagType.TAG_End);
  }
  
  void load (DataInput dis) {
    _tags.clear();
    Tag tag;
    while ((tag = Tag.readNamedTag(dis)).ID != TagType.TAG_End) {
      _tags[tag.name] = tag;
    }
  }
  
  int get ID => TagType.TAG_Compound;
  
  Map toJson () {
    return super.toJson()..addAll({ "tags": _tags });
  }
  
  Iterable<Tag> getAllTags () {
    return _tags.values;
  }
  
  /*** 
   * Puts a named tag inside this compound
   */
  void put (String name, Tag tag) {
    _tags[name] = tag..name = name;
  }
  
  /*** 
   * Puts a byte representation of the int [byte] into the compound
   */
  void putByte (String name, int byte) {
    _tags[name] = new ByteTag(name, byte);
  }
  
  /*** 
   * Puts a short representation of the int [short] into the compound
   */
  void putShort (String name, int short) {
    _tags[name] = new ShortTag (name, short);
  }
  
  /*** 
   * Puts an integer into the compound
   */
  void putInt (String name, int value) {
    _tags[name] = new IntTag(name, value);
  }
  
  /*** 
   * Puts a byte representation of a Long into the compound
   * Endianness is determined on write or when you retreive
   */
  void putLong (String name, List longBytes) {
    _tags[name] = new LongTag(name, longBytes);
  }
  
  /*** 
   * Puts a float(4 bits) into the compound
   */
  void putFloat (String name, double float) {
    _tags[name] = new FloatTag(name, float);
  }
  
  /*** 
   * Puts a double (8 bits) into the compound
   */
  void putDouble (String name, double value) {
    _tags[name] = new DoubleTag(name, value);
  }

  /*** 
   * Puts a string into the compound. Max length for writing is Max_Short
   */
  void putString (String name, String value) {
    _tags[name] = new StringTag(name, value);
  }
  
  /*** 
   * Puts a byte array into the compound
   */
  void putByteArray(String name, List<int> bytes) {
    _tags[name] = new ByteArrayTag(name, bytes);
  }
  
  /*** 
   * Puts an int array into the compound
   */
  void putIntArray (String name, List<int> values) {
    _tags[name] = new IntArrayTag(name, values);
  }
  
  /*** 
   * Puts another compound into the compound
   * [name] overrides [value]'s name
   */  
  void putCompound (String name, CompoundTag value) {
    _tags[name] = value..name = name;
  }
  
  /*** 
   * Puts a byte into the compound
   * 
   * if [val] is true then byte = 1
   * else byte = 0
   */
  void putBoolean (String name, bool val) {
    putByte(name, val ? 0x01 : 0x00);
  }
  
  /***
   * Gets a named tag from the compound
   */
  Tag get (String name) {
    return _tags[name];
  }
  
  /***
   * Checks if a tag named [name] exists inside this compound
   */
  bool contains (String name) {
    return _tags.containsKey(name);
  }
  
  /***
   * Gets a named byte from the compound
   */
  int getByte(String name) {
    if (!contains(name)) return 0;
    return (get(name) as ByteTag).data;
  }
  
  /***
   * Gets a named short from the compound
   */
  int getShort(String name) {
    if (!contains(name)) return 0;
    return (get(name) as ShortTag).data;
  }
  
  /***
   * Gets a named integer from the compound
   */
  int getInt (String name) {
    if (!contains(name)) return 0;
    return (get(name) as IntTag).data;
  }

  /***
   * Gets a named long from the compound
   */
  List<int> getLong (String name) {
    if (!contains(name)) return [0,0,0,0,0,0,0,0];
    return (get(name) as LongTag).data;
  }
  
  /***
   * Gets a named float from the compound
   */  
  double getFloat (String name) {
    if (!contains(name)) return 0.0;
    return (get(name) as FloatTag).data;
  }
  
  /***
   * Gets a named double from the compound
   */
  double getDouble (String name) {
    if (!contains(name)) return 0.0;
    return (get(name) as DoubleTag).data;
  }
  
  /***
   * Gets a named string from the compound
   */
  String getString(String name) {
    if (!contains(name)) return "";
    return (get(name) as StringTag).data;
  }
  
  /***
   * Gets a named byte array from the compound
   */
  List<int> getByteArray (String name) {
    if (!contains(name)) return [];
    return (get(name) as ByteArrayTag).data;
  }
  
  /***
   * Gets a named int array from the compound
   */
  List<int> getIntArray (String name) {
    if (!contains(name)) return [];
    return (get(name) as IntArrayTag).data;    
  }
  
  /***
   * Gets a named compound from the compound
   */
  CompoundTag getCompound (String name) {
    if (!contains(name)) return new CompoundTag(name);
    return get(name) as CompoundTag;
  }
  
  /***
   * Gets a named tag list from the compound
   */
  ListTag getList (String name) {
    if (!contains(name)) return new ListTag<Tag>(name);
    return get(name) as ListTag;
  }
  
  /***
   * Gets a named boolean from the compound
   */
  bool getBoolean (String name) {
   return getByte(name) != 0;
  }
  
  /***
   * Returns true if this compound contains no tags
   */
  bool isEmpty () {
    return _tags.isEmpty;
  }
  
  Tag copy () {
    CompoundTag tag = new CompoundTag(name);
    for (String key in _tags.keys) {
      tag.put(key, get(key));
    }
    return tag;
  }
  
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   hb.add(_tags.length);
   // TODO: This is probably very slow
   List sortedKeys = _tags.keys.toList()..sort((a,b) { return a.compareTo(b); });
   sortedKeys.forEach((String key) { 
     hb.add(_tags[key]);     
   });
   return hb.getHash();   
  }
  
  operator == (dynamic other) {
    if (super == other) {
      CompoundTag o = other;
      return const MapEquality<String, Tag>().equals(o._tags, _tags);
    }
    return false;
  }
}





