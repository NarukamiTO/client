package _codec.projects.tanks.client.battlefield.models.bonus.battle.bonusregions {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecBonusRegionData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_position:ICodec;
    private var codec_regionType:ICodec;
    private var codec_rotation:ICodec;

    public function CodecBonusRegionData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_regionType = param1.getCodec(new EnumCodecInfo(BonusesType,false));
      this.codec_rotation = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusRegionData = new BonusRegionData();
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.regionType = this.codec_regionType.decode(param1) as BonusesType;
      local2.rotation = this.codec_rotation.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusRegionData = BonusRegionData(param2);
      this.codec_position.encode(param1,local3.position);
      this.codec_regionType.encode(param1,local3.regionType);
      this.codec_rotation.encode(param1,local3.rotation);
    }
  }
}
