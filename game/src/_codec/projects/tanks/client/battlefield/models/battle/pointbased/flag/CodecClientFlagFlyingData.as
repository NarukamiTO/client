package _codec.projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagFlyPoint;

  public class CodecClientFlagFlyingData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currentTime:ICodec;
    private var codec_falling:ICodec;
    private var codec_points:ICodec;

    public function CodecClientFlagFlyingData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currentTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_falling = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_points = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(FlagFlyPoint,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClientFlagFlyingData = new ClientFlagFlyingData();
      local2.currentTime = this.codec_currentTime.decode(param1) as int;
      local2.falling = this.codec_falling.decode(param1) as Boolean;
      local2.points = this.codec_points.decode(param1) as Vector.<FlagFlyPoint>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClientFlagFlyingData = ClientFlagFlyingData(param2);
      this.codec_currentTime.encode(param1,local3.currentTime);
      this.codec_falling.encode(param1,local3.falling);
      this.codec_points.encode(param1,local3.points);
    }
  }
}
