package _codec.projects.tanks.client.panel.model.shop.androidspecialoffer.banner {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.panel.model.shop.androidspecialoffer.banner.AndroidBannerType;

  public class CodecAndroidBannerType implements ICodec {
    public function CodecAndroidBannerType() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AndroidBannerType = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = AndroidBannerType.BEGINNER_QUEST;
          break;
        case 1:
          local2 = AndroidBannerType.BATTLE_PASS;
          break;
        case 2:
          local2 = AndroidBannerType.BEGINNER_STARTER_PACK;
          break;
        case 3:
          local2 = AndroidBannerType.PREMIUM_SPECIAL_OFFER;
          break;
        case 4:
          local2 = AndroidBannerType.MEDIUM_TIME_PACK;
          break;
        case 5:
          local2 = AndroidBannerType.KIT_FULL_OFFER;
          break;
        case 6:
          local2 = AndroidBannerType.PROGRESS_OFFER;
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
