package _codec.projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagFlyPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlyingMode;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecFlagFlyPoint implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_mode:ICodec;
    private var codec_position:ICodec;
    private var codec_rotation_w:ICodec;
    private var codec_rotation_x:ICodec;
    private var codec_rotation_y:ICodec;
    private var codec_rotation_z:ICodec;
    private var codec_time:ICodec;

    public function CodecFlagFlyPoint() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_mode = param1.getCodec(new EnumCodecInfo(FlyingMode,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_rotation_w = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_rotation_x = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_rotation_y = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_rotation_z = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_time = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FlagFlyPoint = new FlagFlyPoint();
      local2.mode = this.codec_mode.decode(param1) as FlyingMode;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.rotation_w = this.codec_rotation_w.decode(param1) as Number;
      local2.rotation_x = this.codec_rotation_x.decode(param1) as Number;
      local2.rotation_y = this.codec_rotation_y.decode(param1) as Number;
      local2.rotation_z = this.codec_rotation_z.decode(param1) as Number;
      local2.time = this.codec_time.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FlagFlyPoint = FlagFlyPoint(param2);
      this.codec_mode.encode(param1,local3.mode);
      this.codec_position.encode(param1,local3.position);
      this.codec_rotation_w.encode(param1,local3.rotation_w);
      this.codec_rotation_x.encode(param1,local3.rotation_x);
      this.codec_rotation_y.encode(param1,local3.rotation_y);
      this.codec_rotation_z.encode(param1,local3.rotation_z);
      this.codec_time.encode(param1,local3.time);
    }
  }
}
