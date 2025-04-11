package _codec.projects.tanks.client.battlefield.models.battle.jgr {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.jgr.JuggernautCC;

  public class CodecJuggernautCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bossHudMarker:ICodec;
    private var codec_bossKilledSound:ICodec;
    private var codec_bossSpawnedSound:ICodec;
    private var codec_currentBoss:ICodec;

    public function CodecJuggernautCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bossHudMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bossKilledSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_bossSpawnedSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_currentBoss = param1.getCodec(new TypeCodecInfo(IGameObject,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:JuggernautCC = new JuggernautCC();
      local2.bossHudMarker = this.codec_bossHudMarker.decode(param1) as TextureResource;
      local2.bossKilledSound = this.codec_bossKilledSound.decode(param1) as SoundResource;
      local2.bossSpawnedSound = this.codec_bossSpawnedSound.decode(param1) as SoundResource;
      local2.currentBoss = this.codec_currentBoss.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:JuggernautCC = JuggernautCC(param2);
      this.codec_bossHudMarker.encode(param1,local3.bossHudMarker);
      this.codec_bossKilledSound.encode(param1,local3.bossKilledSound);
      this.codec_bossSpawnedSound.encode(param1,local3.bossSpawnedSound);
      this.codec_currentBoss.encode(param1,local3.currentBoss);
    }
  }
}
