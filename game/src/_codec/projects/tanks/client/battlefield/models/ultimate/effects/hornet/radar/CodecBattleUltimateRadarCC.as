package _codec.projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarCC;

  public class CodecBattleUltimateRadarCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_blueTankMarker:ICodec;
    private var codec_discoveredTanksIds:ICodec;
    private var codec_farMarkerDistance:ICodec;
    private var codec_nearMarkerDistance:ICodec;
    private var codec_neutralTankMarker:ICodec;
    private var codec_redTankMarker:ICodec;

    public function CodecBattleUltimateRadarCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_blueTankMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_discoveredTanksIds = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_farMarkerDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_nearMarkerDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_neutralTankMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redTankMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleUltimateRadarCC = new BattleUltimateRadarCC();
      local2.blueTankMarker = this.codec_blueTankMarker.decode(param1) as TextureResource;
      local2.discoveredTanksIds = this.codec_discoveredTanksIds.decode(param1) as Vector.<Long>;
      local2.farMarkerDistance = this.codec_farMarkerDistance.decode(param1) as Number;
      local2.nearMarkerDistance = this.codec_nearMarkerDistance.decode(param1) as Number;
      local2.neutralTankMarker = this.codec_neutralTankMarker.decode(param1) as TextureResource;
      local2.redTankMarker = this.codec_redTankMarker.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleUltimateRadarCC = BattleUltimateRadarCC(param2);
      this.codec_blueTankMarker.encode(param1,local3.blueTankMarker);
      this.codec_discoveredTanksIds.encode(param1,local3.discoveredTanksIds);
      this.codec_farMarkerDistance.encode(param1,local3.farMarkerDistance);
      this.codec_nearMarkerDistance.encode(param1,local3.nearMarkerDistance);
      this.codec_neutralTankMarker.encode(param1,local3.neutralTankMarker);
      this.codec_redTankMarker.encode(param1,local3.redTankMarker);
    }
  }
}
