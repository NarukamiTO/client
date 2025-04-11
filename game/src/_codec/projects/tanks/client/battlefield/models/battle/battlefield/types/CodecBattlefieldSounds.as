package _codec.projects.tanks.client.battlefield.models.battle.battlefield.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.BattlefieldSounds;

  public class CodecBattlefieldSounds implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleFinishSound:ICodec;
    private var codec_killSound:ICodec;

    public function CodecBattlefieldSounds() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleFinishSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_killSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattlefieldSounds = new BattlefieldSounds();
      local2.battleFinishSound = this.codec_battleFinishSound.decode(param1) as SoundResource;
      local2.killSound = this.codec_killSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattlefieldSounds = BattlefieldSounds(param2);
      this.codec_battleFinishSound.encode(param1,local3.battleFinishSound);
      this.codec_killSound.encode(param1,local3.killSound);
    }
  }
}
