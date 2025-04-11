package _codec.projects.tanks.client.battlefield.models.battle.cp {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointsCC;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;

  public class CodecControlPointsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_keypointTriggerRadius:ICodec;
    private var codec_keypointVisorHeight:ICodec;
    private var codec_minesRestrictionRadius:ICodec;
    private var codec_points:ICodec;
    private var codec_resources:ICodec;
    private var codec_sounds:ICodec;

    public function CodecControlPointsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_keypointTriggerRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_keypointVisorHeight = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minesRestrictionRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_points = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ClientPointData,false),false,1));
      this.codec_resources = param1.getCodec(new TypeCodecInfo(DominationResources,false));
      this.codec_sounds = param1.getCodec(new TypeCodecInfo(DominationSounds,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ControlPointsCC = new ControlPointsCC();
      local2.keypointTriggerRadius = this.codec_keypointTriggerRadius.decode(param1) as Number;
      local2.keypointVisorHeight = this.codec_keypointVisorHeight.decode(param1) as Number;
      local2.minesRestrictionRadius = this.codec_minesRestrictionRadius.decode(param1) as Number;
      local2.points = this.codec_points.decode(param1) as Vector.<ClientPointData>;
      local2.resources = this.codec_resources.decode(param1) as DominationResources;
      local2.sounds = this.codec_sounds.decode(param1) as DominationSounds;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ControlPointsCC = ControlPointsCC(param2);
      this.codec_keypointTriggerRadius.encode(param1,local3.keypointTriggerRadius);
      this.codec_keypointVisorHeight.encode(param1,local3.keypointVisorHeight);
      this.codec_minesRestrictionRadius.encode(param1,local3.minesRestrictionRadius);
      this.codec_points.encode(param1,local3.points);
      this.codec_resources.encode(param1,local3.resources);
      this.codec_sounds.encode(param1,local3.sounds);
    }
  }
}
