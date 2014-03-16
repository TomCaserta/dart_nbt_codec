library hashbuilder;
import "dart:math";

/***
 * TODO: ACTUALLY MAKE THIS WORK, I HAVE NFI WHAT IM DOING.
 */
class HashBuilder {
  int primeValue;
  List _items = [];
  
  
  HashBuilder ();  
  
  void add (dynamic item) {
    _items.add(item);
  }
  static int getHashResult (dynamic item) {
    if (item == null) {
      return 0;
    }
    else if (item is int) {
      return item;
    }
    else if (item is double) {
      // TODO: Do something sensible here and not this:
      // Seriously I have no idea what im doing here. 
      return (item * 1000000000000).toInt();
    }
    else if (item is List) {
      int currResult = 0;
      item.forEach((dynamic other) { 
        currResult = 37 * getHashResult(other) + currResult;
      });
      return currResult;
    }
    else {
      return item.hashCode;
    }
    
    return 0;                
  }
  int getHash () {
    int result = 1;
    if (_items != null) {
      int l = _items.length;
      for (int x = 0; x < l; x++)  {
        int c = getHashResult(_items[x]);
        result = 37 * ((c == 0 ? 1 : c) * (result == 0 ? 1 : result));
      }
    }
    return result;
  }
}