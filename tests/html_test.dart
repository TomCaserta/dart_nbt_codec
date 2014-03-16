import "dart:html";
import "package:unittest/unittest.dart";
import "package:unittest/html_enhanced_config.dart";
import "big_test.dart";
import "package:nbt_codec/nbt_codec.dart";

void main () {
  // Used to run the function from the other library... for some reason there's
  // per library configs.
  runFunc(() { useHtmlEnhancedConfiguration(); });
  HttpRequest req = new HttpRequest();
  req.open("GET", "nbt_data/decompressed_bigtest.nbt");
  req.responseType = "arraybuffer";
  req.send();
  req.onLoadEnd.listen((e) { 
       CompoundTag bigTest = readNBT(req.response);
       doBigTest("From File", bigTest);
       
       CompoundTag bigTest2 = readNBT(writeNBT(bigTest));
       doBigTest("From written output", bigTest2);
    
  });

  HttpRequest req2 = new HttpRequest();
  req2.open("GET", "nbt_data/bigtest.nbt");
  req2.responseType = "arraybuffer";
  req2.send();
  req2.onLoadEnd.listen((e) { 
       CompoundTag bigTest = readNBT(req2.response, compressionType: CompressionType.G_ZIP);
       doBigTest("From Compressed File", bigTest);
       
  });

}