package _codec.projects.tanks.client.battlefield.models.battle.jgr.killstreak {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakItem;

  public class CodecKillStreakItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_messageToBoss:ICodec;
    private var codec_messageToVictims:ICodec;
    private var codec_sound:ICodec;

    public function CodecKillStreakItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_messageToBoss = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_messageToVictims = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_sound = param1.getCodec(new TypeCodecInfo(SoundResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KillStreakItem = new KillStreakItem();
      local2.count = this.codec_count.decode(param1) as int;
      local2.messageToBoss = this.codec_messageToBoss.decode(param1) as String;
      local2.messageToVictims = this.codec_messageToVictims.decode(param1) as String;
      local2.sound = this.codec_sound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KillStreakItem = KillStreakItem(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_messageToBoss.encode(param1,local3.messageToBoss);
      this.codec_messageToVictims.encode(param1,local3.messageToVictims);
      this.codec_sound.encode(param1,local3.sound);
    }
  }
}
