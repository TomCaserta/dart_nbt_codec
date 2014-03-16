import "packages/unittest/unittest.dart";
import "package:fixnum/fixnum.dart";
import "package:nbt_codec/nbt_codec.dart";
void runFunc (Function f) {
  f();
}
void doBigTest (String name, CompoundTag bigTest) {
  group("Big Test -> $name", () {
    
    test("Compound Name", () {
      expect(bigTest.name, "Level");
    });
    
    group("Byte Array", () {
      String name = "byteArrayTest (the first 1000 values of (n*n*255+n*7)%100, starting with n=0 (0, 62, 34, 16, 8, ...))";
      List<int> expected = new List<int>(1000);
      for (int x = 0; x < 1000; x++) {
        expected[x] = (x * x * 255 + x * 7) % 100;
      }
      ByteArrayTag expectedTag = new ByteArrayTag(name, expected);
      test("from get",() {
        // Yeah that long string is the name of the tag from the given test file :/
        ByteArrayTag byteArr = bigTest.get(name);
        expect(byteArr, expectedTag);
      });
      
      test("from getByteArray", () {
        expect(bigTest.getByteArray(name), expected);
      });
    });
          
    group("Byte", () {   
      String name = "byteTest";
      int expected = 127;
      ByteTag expectedTag = new ByteTag(name, expected);
      test("from get",() {
        ByteTag byte = bigTest.get(name);
        expect(byte, expectedTag);
      });
      
      test("from getByte", () {
        expect(bigTest.getByte(name), expected);
      });        
    });
    
    group("Short", () {   
      String name = "shortTest";
      int expected = 32767;
      ShortTag expectedTag = new ShortTag(name, expected);
      test("from get",() {
        ShortTag short = bigTest.get(name);
        expect(short, expectedTag);
      });
      
      test("from getShort", () {
        expect(bigTest.getShort(name), expected);
      });        
    });
    
    group("Int", () {   
       String name = "intTest";
       int expected = 2147483647;
       IntTag expectedTag = new IntTag(name, expected);
       test("from get",() {
         IntTag integer = bigTest.get(name);
         expect(integer, expectedTag);
       });
       
       test("from getByte", () {
         expect(bigTest.getInt(name), expected);
       });        
     });
     
    group("String", () {   
      String name = "stringTest";
      String expected = "HELLO WORLD THIS IS A TEST STRING ÅÄÖ!";
      StringTag expectedTag = new StringTag(name, expected);
      test("from get",() {
        StringTag string = bigTest.get(name);
        expect(string, expectedTag);
      });
      
      test("from getString", () {
        expect(bigTest.getString(name), expected);
      });        
    });
    
    group("Double", () {   
      String name = "doubleTest";
      double expected = 0.49312871321823148;
      DoubleTag expectedTag = new DoubleTag(name, expected);
      test("from get",() {
        DoubleTag double = bigTest.get(name);
        expect(double, expectedTag);
      });
      
      test("from getDouble", () {
        expect(bigTest.getDouble(name), expected);
      });        
    });
    
    group("Float", () {   
        String name = "floatTest";
        double expected = 0.49823147058486938;
        FloatTag expectedTag = new FloatTag(name, expected);
        test("from get",() {
          FloatTag float = bigTest.get(name);
          expect(float, expectedTag);
        });
        
        test("from getFloat", () {
          expect(bigTest.getFloat(name), expected);
        });        
    }); 
    
    group("Long", () {   
      String name = "longTest";
      Int64 expected = new Int64(9223372036854775807);
      LongTag expectedTag = new LongTag(name, expected);
      test("from get",() {
        LongTag long = bigTest.get(name);
        expect(long, expectedTag);
      });
      
      test("from getLong", () {
        expect(bigTest.getLong(name), expected);
      });        
    });
    
    group("List", () {   
      String name = "listTest (long)";
      List<LongTag> expected = new List<LongTag>()..addAll([new LongTag(null,new Int64(11)),
                              new LongTag(null,new Int64(12)),
                              new LongTag(null,new Int64(13)),
                              new LongTag(null,new Int64(14)),
                              new LongTag(null,new Int64(15))]);
      ListTag<LongTag> expectedTag = new ListTag<LongTag>(name);
      expected.forEach((LongTag tag) { 
        expectedTag.add(tag);
      });
      test("from get",() {
        ListTag list = bigTest.get(name);
        expect(list, expectedTag);
      });
      
      test("from getList", () {
        
        expect(bigTest.getList(name), expectedTag);
      });        
    });
    
    group("List -> Compound", () {   
      String name = "listTest (compound)";
      ListTag<CompoundTag> expectedTag = new ListTag<CompoundTag>(name);
      expectedTag.add(new CompoundTag()..putString("name", "Compound tag #0")..putLong("created-on", new Int64(1264099775885)));  
      expectedTag.add(new CompoundTag()..putString("name", "Compound tag #1")..putLong("created-on", new Int64(1264099775885)));         
      
      test("from get",() {
        ListTag list = bigTest.get(name);
        expect(list, expectedTag);
      });
      
      test("from getList", () {
        expect(bigTest.getList(name), expectedTag);
      });        
    });
    
    group("Compound", () {   
      String name = "nested compound test";
      CompoundTag expected = new CompoundTag(name);
      expected.putCompound("ham",new CompoundTag("ham")..putString("name", "Hampus")..putFloat("value", 0.75));
      expected.putCompound("egg",new CompoundTag("egg")..putString("name", "Eggbert")..putFloat("value", 0.5));
      
      test("equalityCheck", () {
        CompoundTag tag1 = new CompoundTag(name);
        tag1.putBoolean("test", true);
        CompoundTag tag2 = new CompoundTag(name);
        tag2.putBoolean("test", true);
        expect(tag1, tag2);          
      });
      
      //  Order is not preserved so we cant test getAllTags()
      test("from get",() {
        CompoundTag compound = bigTest.get(name);
        expect(compound, expected);
      });
      
      test("from getCompound", () {
        expect(bigTest.getCompound(name), expected);
      });        
    });
  });
}