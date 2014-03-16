import "package:nbt_codec/nbt_codec.dart";
import "dart:io";
import "big_test.dart";

void main () {
    File bigTestFile = new File("./nbt_data/decompressed_bigtest.nbt");
    List<int> inflatedBytes = bigTestFile.readAsBytesSync();  
    CompoundTag bigTest = readNBT(inflatedBytes);
    doBigTest("From File", bigTest);
    
    CompoundTag bigTest2 = readNBT(writeNBT(bigTest));
    doBigTest("From written output", bigTest2);
    
    File gzipedBigTest = new File("./nbt_data/bigtest.nbt");
    List<int> bytes = gzipedBigTest.readAsBytesSync();  
    doBigTest("From GZip File", readNBT(bytes, compressionType: CompressionType.G_ZIP));
}