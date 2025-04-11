package _codec.projects.tanks.client.battlefield.models.battle.cp {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecClientPointData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_id:ICodec;
    private var codec_name:ICodec;
    private var codec_position:ICodec;
    private var codec_score:ICodec;
    private var codec_scoreChangeRate:ICodec;
    private var codec_state:ICodec;
    private var codec_tankIds:ICodec;

    public function CodecClientPointData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_id = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_score = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_scoreChangeRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_state = param1.getCodec(new EnumCodecInfo(ControlPointState,false));
      this.codec_tankIds = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClientPointData = new ClientPointData();
      local2.id = this.codec_id.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.score = this.codec_score.decode(param1) as Number;
      local2.scoreChangeRate = this.codec_scoreChangeRate.decode(param1) as Number;
      local2.state = this.codec_state.decode(param1) as ControlPointState;
      local2.tankIds = this.codec_tankIds.decode(param1) as Vector.<Long>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClientPointData = ClientPointData(param2);
      this.codec_id.encode(param1,local3.id);
      this.codec_name.encode(param1,local3.name);
      this.codec_position.encode(param1,local3.position);
      this.codec_score.encode(param1,local3.score);
      this.codec_scoreChangeRate.encode(param1,local3.scoreChangeRate);
      this.codec_state.encode(param1,local3.state);
      this.codec_tankIds.encode(param1,local3.tankIds);
    }
  }
}
