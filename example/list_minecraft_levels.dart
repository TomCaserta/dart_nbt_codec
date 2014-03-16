import "package:nbt_codec/nbt_codec.dart";
import "dart:io";
import "dart:convert";

void main () {
  print("Listing all world names");
  Directory dir;
  if (Platform.isWindows) { 
    dir = new Directory("${Platform.environment["APPDATA"]}/.minecraft/saves/");
  }
  else if (Platform.isLinux) {
    dir = new Directory("~/.minecraft/saves/");
  }
  else if (Platform.isMacOS) {
    dir = new Directory ("~/Library/Application Support/minecraft/saves/");
  }
  else throw new UnsupportedError("Sorry I dont know how to find minecraft saves on your platform");
  if (dir.existsSync()) {
    dir.listSync().forEach((FileSystemEntity fse) { 
      if (fse is Directory) {
        Directory worldDir = fse;
        File f = new File("${worldDir.path}/level.dat");
        if (f.existsSync()) {
        
          CompoundTag tag = readNBT(f.readAsBytesSync(), compressionType: CompressionType.G_ZIP);
          print("============================================");
          print(tag.getCompound("Data").getString("LevelName"));
          print("Last played on: ${new DateTime.fromMillisecondsSinceEpoch((tag.getCompound("Data").get("LastPlayed") as LongTag).getLong().toInt())}");
        }
      }    
    });
  }
  else throw new Exception("Could not find minecraft saves directory");
    
}