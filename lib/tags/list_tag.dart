part of nbt_codec;

class ListTag<T extends Tag> extends Tag {
  List<T> list = new List<T>();
  int type;
  
  ListTag([String name = ""]):super(name);
  
  void write (DataOutput dos) {
    if (list.length > 0) type = list[0].ID;
    else type = 1;
    
    dos.writeByte(type);
    dos.writeInt(list.length);
    for (int i = 0; i < list.length; i++) {
      list[i].write(dos);
    }
  }
  
  void load (DataInput dis) {
    type = dis.readByte();
    int size = dis.readInt();
    list = new List<T>();
    for (int i = 0; i < size; i++) {
      Tag tag = Tag.newTag(type, null);
      tag.load(dis);
      list.add(tag);
    }
  }
  
  int get ID => Tag.TAG_List;
  
  Map toJson () {
    return super.toJson()..addAll({ "list_type": type, "list_type_name": Tag.getTagName(type), "list": list });
  }
  
  void add (T tag) {
    type = tag.ID;
    list.add(tag);
  }
  
  T get (int index) {
    return list[index];
  }
  
  Tag copy () {
    ListTag<T> res = new ListTag<T>(name);
    res.type = type;
    for (Tag t in list) {
      T copy = t.copy();
      res.list.add(copy);
    }
    return res;
  }
  
  int get hashCode {
   HashBuilder hb = new HashBuilder();
   hb.add(ID);
   hb.add(name);
   hb.add(list);
   return hb.getHash();   
  }
  
  operator == (dynamic other) {
    if (super == other) {
      ListTag o = other;
      if (type == o.type){
        return const ListEquality().equals(list, o.list);
      }
    }
    return false;
  }
}