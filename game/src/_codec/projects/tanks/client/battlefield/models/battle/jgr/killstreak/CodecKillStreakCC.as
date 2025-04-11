package _codec.projects.tanks.client.battlefield.models.battle.jgr.killstreak {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakCC;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakItem;

  public class CodecKillStreakCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_items:ICodec;

    public function CodecKillStreakCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_items = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(KillStreakItem,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KillStreakCC = new KillStreakCC();
      local2.items = this.codec_items.decode(param1) as Vector.<KillStreakItem>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KillStreakCC = KillStreakCC(param2);
      this.codec_items.encode(param1,local3.items);
    }
  }
}
