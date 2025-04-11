package _codec.projects.tanks.client.battleservice.model.map.params {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class CodecMapTheme implements ICodec {
    public function CodecMapTheme() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MapTheme = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = MapTheme.SUMMER;
          break;
        case 1:
          local2 = MapTheme.WINTER;
          break;
        case 2:
          local2 = MapTheme.DAY;
          break;
        case 3:
          local2 = MapTheme.NIGHT;
          break;
        case 4:
          local2 = MapTheme.SUMMER_DAY;
          break;
        case 5:
          local2 = MapTheme.SUMMER_NIGHT;
          break;
        case 6:
          local2 = MapTheme.WINTER_DAY;
          break;
        case 7:
          local2 = MapTheme.WINTER_NIGHT;
          break;
        case 8:
          local2 = MapTheme.SPACE;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
