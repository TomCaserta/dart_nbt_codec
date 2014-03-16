part of nbt_codec;

class TagType {
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
}