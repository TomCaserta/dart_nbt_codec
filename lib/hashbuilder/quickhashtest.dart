import "hashbuilder.dart";
// TODO: remove this file

void main () {
  int x = 0;
  int y = -22222222222222222;
  List s = [1,2,3,4,5,6];
  HashBuilder b = new HashBuilder();
  HashBuilder hb = new HashBuilder();
  hb.add(x);
  hb.add(y);
  hb.add(s);
  hb.add(b);
  print(hb.getHash());
  
}