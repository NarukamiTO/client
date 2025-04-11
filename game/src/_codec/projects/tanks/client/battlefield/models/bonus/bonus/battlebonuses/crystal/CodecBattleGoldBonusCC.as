package _codec.projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.BattleGoldBonusCC;

  public class CodecBattleGoldBonusCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_sound:ICodec;
    private var codec_sprite:ICodec;

    public function CodecBattleGoldBonusCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_sprite = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleGoldBonusCC = new BattleGoldBonusCC();
      local2.sound = this.codec_sound.decode(param1) as SoundResource;
      local2.sprite = this.codec_sprite.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleGoldBonusCC = BattleGoldBonusCC(param2);
      this.codec_sound.encode(param1,local3.sound);
      this.codec_sprite.encode(param1,local3.sprite);
    }
  }
}
