part of nbt_codec;

class EndTag extends Tag {
  EndTag():super(null);
  void load (DataInput dis) {}
  void write (DataOutput dos) {}
  
  int get ID => TagType.TAG_End;
   
  Tag copy () {
    return new EndTag();
  }
  
}