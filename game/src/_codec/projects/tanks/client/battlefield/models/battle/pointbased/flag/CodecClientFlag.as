package _codec.projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecClientFlag implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_fallingData:ICodec;
    private var codec_flagCarrierId:ICodec;
    private var codec_flagId:ICodec;
    private var codec_flagPosition:ICodec;
    private var codec_state:ICodec;

    public function CodecClientFlag() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_fallingData = param1.getCodec(new TypeCodecInfo(ClientFlagFlyingData,false));
      this.codec_flagCarrierId = param1.getCodec(new TypeCodecInfo(Long,true));
      this.codec_flagId = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_flagPosition = param1.getCodec(new TypeCodecInfo(Vector3d,true));
      this.codec_state = param1.getCodec(new EnumCodecInfo(FlagState,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClientFlag = new ClientFlag();
      local2.fallingData = this.codec_fallingData.decode(param1) as ClientFlagFlyingData;
      local2.flagCarrierId = this.codec_flagCarrierId.decode(param1) as Long;
      local2.flagId = this.codec_flagId.decode(param1) as int;
      local2.flagPosition = this.codec_flagPosition.decode(param1) as Vector3d;
      local2.state = this.codec_state.decode(param1) as FlagState;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClientFlag = ClientFlag(param2);
      this.codec_fallingData.encode(param1,local3.fallingData);
      this.codec_flagCarrierId.encode(param1,local3.flagCarrierId);
      this.codec_flagId.encode(param1,local3.flagId);
      this.codec_flagPosition.encode(param1,local3.flagPosition);
      this.codec_state.encode(param1,local3.state);
    }
  }
}
