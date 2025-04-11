package _codec.projects.tanks.client.battlefield.models.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.map.BattleMapCC;
  import projects.tanks.client.battlefield.models.map.DustParams;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.client.battlefield.models.map.FogParams;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.MapResource;

  public class CodecBattleMapCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_dustParams:ICodec;
    private var codec_dynamicShadowParams:ICodec;
    private var codec_environmentSound:ICodec;
    private var codec_fogParams:ICodec;
    private var codec_gravity:ICodec;
    private var codec_mapResource:ICodec;
    private var codec_skyBoxRevolutionAxis:ICodec;
    private var codec_skyBoxRevolutionSpeed:ICodec;
    private var codec_skyboxSides:ICodec;
    private var codec_ssaoColor:ICodec;

    public function CodecBattleMapCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_dustParams = param1.getCodec(new TypeCodecInfo(DustParams,false));
      this.codec_dynamicShadowParams = param1.getCodec(new TypeCodecInfo(DynamicShadowParams,false));
      this.codec_environmentSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_fogParams = param1.getCodec(new TypeCodecInfo(FogParams,false));
      this.codec_gravity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_mapResource = param1.getCodec(new TypeCodecInfo(MapResource,false));
      this.codec_skyBoxRevolutionAxis = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_skyBoxRevolutionSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_skyboxSides = param1.getCodec(new TypeCodecInfo(SkyboxSides,false));
      this.codec_ssaoColor = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleMapCC = new BattleMapCC();
      local2.dustParams = this.codec_dustParams.decode(param1) as DustParams;
      local2.dynamicShadowParams = this.codec_dynamicShadowParams.decode(param1) as DynamicShadowParams;
      local2.environmentSound = this.codec_environmentSound.decode(param1) as SoundResource;
      local2.fogParams = this.codec_fogParams.decode(param1) as FogParams;
      local2.gravity = this.codec_gravity.decode(param1) as Number;
      local2.mapResource = this.codec_mapResource.decode(param1) as MapResource;
      local2.skyBoxRevolutionAxis = this.codec_skyBoxRevolutionAxis.decode(param1) as Vector3d;
      local2.skyBoxRevolutionSpeed = this.codec_skyBoxRevolutionSpeed.decode(param1) as Number;
      local2.skyboxSides = this.codec_skyboxSides.decode(param1) as SkyboxSides;
      local2.ssaoColor = this.codec_ssaoColor.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleMapCC = BattleMapCC(param2);
      this.codec_dustParams.encode(param1,local3.dustParams);
      this.codec_dynamicShadowParams.encode(param1,local3.dynamicShadowParams);
      this.codec_environmentSound.encode(param1,local3.environmentSound);
      this.codec_fogParams.encode(param1,local3.fogParams);
      this.codec_gravity.encode(param1,local3.gravity);
      this.codec_mapResource.encode(param1,local3.mapResource);
      this.codec_skyBoxRevolutionAxis.encode(param1,local3.skyBoxRevolutionAxis);
      this.codec_skyBoxRevolutionSpeed.encode(param1,local3.skyBoxRevolutionSpeed);
      this.codec_skyboxSides.encode(param1,local3.skyboxSides);
      this.codec_ssaoColor.encode(param1,local3.ssaoColor);
    }
  }
}
