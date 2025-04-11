package _codec.projects.tanks.client.battlefield.models.battle.pointbased.rugby {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbyCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.RugbySoundFX;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecRugbyCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_ballFallSpeeed:ICodec;
    private var codec_ballModel:ICodec;
    private var codec_ballRadius:ICodec;
    private var codec_ballSpawnZone:ICodec;
    private var codec_bigBlueBallMarker:ICodec;
    private var codec_bigGreenBallMarker:ICodec;
    private var codec_bigRedBallMarker:ICodec;
    private var codec_blueBallMarker:ICodec;
    private var codec_blueGoalModel:ICodec;
    private var codec_cordResource:ICodec;
    private var codec_greenBallMarker:ICodec;
    private var codec_parachuteInnerResource:ICodec;
    private var codec_parachuteResource:ICodec;
    private var codec_redBallMarker:ICodec;
    private var codec_redGoalModel:ICodec;
    private var codec_sounds:ICodec;

    public function CodecRugbyCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_ballFallSpeeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_ballModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_ballRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_ballSpawnZone = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bigBlueBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bigGreenBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_bigRedBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueGoalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_cordResource = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_greenBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_parachuteInnerResource = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_parachuteResource = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_redBallMarker = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redGoalModel = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_sounds = param1.getCodec(new TypeCodecInfo(RugbySoundFX,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RugbyCC = new RugbyCC();
      local2.ballFallSpeeed = this.codec_ballFallSpeeed.decode(param1) as Number;
      local2.ballModel = this.codec_ballModel.decode(param1) as Tanks3DSResource;
      local2.ballRadius = this.codec_ballRadius.decode(param1) as Number;
      local2.ballSpawnZone = this.codec_ballSpawnZone.decode(param1) as TextureResource;
      local2.bigBlueBallMarker = this.codec_bigBlueBallMarker.decode(param1) as TextureResource;
      local2.bigGreenBallMarker = this.codec_bigGreenBallMarker.decode(param1) as TextureResource;
      local2.bigRedBallMarker = this.codec_bigRedBallMarker.decode(param1) as TextureResource;
      local2.blueBallMarker = this.codec_blueBallMarker.decode(param1) as TextureResource;
      local2.blueGoalModel = this.codec_blueGoalModel.decode(param1) as Tanks3DSResource;
      local2.cordResource = this.codec_cordResource.decode(param1) as TextureResource;
      local2.greenBallMarker = this.codec_greenBallMarker.decode(param1) as TextureResource;
      local2.parachuteInnerResource = this.codec_parachuteInnerResource.decode(param1) as Tanks3DSResource;
      local2.parachuteResource = this.codec_parachuteResource.decode(param1) as Tanks3DSResource;
      local2.redBallMarker = this.codec_redBallMarker.decode(param1) as TextureResource;
      local2.redGoalModel = this.codec_redGoalModel.decode(param1) as Tanks3DSResource;
      local2.sounds = this.codec_sounds.decode(param1) as RugbySoundFX;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RugbyCC = RugbyCC(param2);
      this.codec_ballFallSpeeed.encode(param1,local3.ballFallSpeeed);
      this.codec_ballModel.encode(param1,local3.ballModel);
      this.codec_ballRadius.encode(param1,local3.ballRadius);
      this.codec_ballSpawnZone.encode(param1,local3.ballSpawnZone);
      this.codec_bigBlueBallMarker.encode(param1,local3.bigBlueBallMarker);
      this.codec_bigGreenBallMarker.encode(param1,local3.bigGreenBallMarker);
      this.codec_bigRedBallMarker.encode(param1,local3.bigRedBallMarker);
      this.codec_blueBallMarker.encode(param1,local3.blueBallMarker);
      this.codec_blueGoalModel.encode(param1,local3.blueGoalModel);
      this.codec_cordResource.encode(param1,local3.cordResource);
      this.codec_greenBallMarker.encode(param1,local3.greenBallMarker);
      this.codec_parachuteInnerResource.encode(param1,local3.parachuteInnerResource);
      this.codec_parachuteResource.encode(param1,local3.parachuteResource);
      this.codec_redBallMarker.encode(param1,local3.redBallMarker);
      this.codec_redGoalModel.encode(param1,local3.redGoalModel);
      this.codec_sounds.encode(param1,local3.sounds);
    }
  }
}
