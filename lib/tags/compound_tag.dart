part of nbt_codec;

class CompoundTag extends Tag {
  Map<String, Tag> _tags = new Map<String, Tag>();
  
  CompoundTag([String name]):super(name);
  
  void write (DataOutput dos) {
    for (Tag tag in _tags.values) {
      Tag.writeNamedTag(tag, dos);
    }
    dos.writeByte(Tag.TAG_End);
  }
  
  void load (DataInput dis) {
    _tags.clear();
    Tag tag;
    while ((tag = Tag.readNamedTag(dis)).ID != Tag.TAG_End) {
      _tags[tag.name] = tag;
    }
  }
  
  int get ID => Tag.TAG_Compound;
  
  Map toJson () {
    return super.toJson()..addAll({ "tags": _tags });
  }
  
  Iterable<Tag> getAllTags () {
    return _tags.values;
  }
  
  void put (String name, Tag tag) {
    _tags[name] = tag..name = name;
  }
  
  void putByte (String name, int byte) {
    _tags[name] = new ByteTag(name, byte);
  }
  
  void putShort (String name, int short) {
    _tags[name] = new ShortTag (name, short);
  }
  
  void putInt (String name, int value) {
    _tags[name] = new IntTag(name, value);
  }
  
  void putLong (String name, Int64 long) {
    _tags[name] = new LongTag(name, long);
  }
  
  void putFloat (String name, num float) {
    _tags[name] = new FloatTag(name, float);
  }
  
  void putDouble (String name, double value) {
    _tags[name] = new DoubleTag(name, value);
  }

  void putString (String name, String value) {
    _tags[name] = new StringTag(name, value);
  }
  
  void putByteArray(String name, List<int> bytes) {
    _tags[name] = new ByteArrayTag(name, bytes);
  }
  
  void putIntArray (String name, List<int> values) {
    _tags[name] = new IntArrayTag(name, values);
  }
  
  void putCompound (String name, CompoundTag value) {
    _tags[name] = value..name = name;
  }
  
  void putBoolean (String name, bool val) {
    putByte(name, val ? 0x01 : 0x00);
  }
  
  Tag get (String name) {
    return _tags[name];
  }
  
  bool contains (String name) {
    return _tags.containsKey(name);
  }
  
  int getByte(String name) {
    if (!contains(name)) return 0;
    return (get(name) as ByteTag).data;
  }
  
  int getShort(String name) {
    if (!contains(name)) return 0;
    return (get(name) as ShortTag).data;
  }
  
  int getInt (String name) {
    if (!contains(name)) return 0;
    return (get(name) as IntTag).data;
  }
  
  Int64 getLong (String name) {
    if (!contains(name)) return new Int64(0);
    return (get(name) as LongTag).data;
  }
  
  double getFloat (String name) {
    if (!contains(name)) return 0.0;
    return (get(name) as FloatTag).data;
  }
  
  double getDouble (String name) {
    if (!contains(name)) return 0.0;
    return (get(name) as DoubleTag).data;
  }
  
  String getString(String name) {
    if (!contains(name)) return "";
    return (get(name) as StringTag).data;
  }
  
  List<int> getByteArray (String name) {
    if (!contains(name)) return [];
    return (get(name) as ByteArrayTag).data;
  }
  
  List<int> getIntArray (String name) {
    if (!contains(name)) return [];
    return (get(name) as IntArrayTag).data;    
  }
  
  CompoundTag getCompound (String name) {
    if (!contains(name)) return new CompoundTag(name);
    return get(name) as CompoundTag;
  }
  
  ListTag getList (String name) {
    if (!contains(name)) return new ListTag<Tag>(name);
    return get(name) as ListTag;
  }
  
  bool getBoolean (String name) {
   return getByte(name) != 0;
  }
  
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





