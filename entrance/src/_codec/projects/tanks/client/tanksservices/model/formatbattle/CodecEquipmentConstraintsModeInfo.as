package _codec.projects.tanks.client.tanksservices.model.formatbattle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsModeInfo;

  public class CodecEquipmentConstraintsModeInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_index:ICodec;
    private var codec_mode:ICodec;
    private var codec_name:ICodec;

    public function CodecEquipmentConstraintsModeInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_index = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_mode = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EquipmentConstraintsModeInfo = new EquipmentConstraintsModeInfo();
      local2.index = this.codec_index.decode(param1) as int;
      local2.mode = this.codec_mode.decode(param1) as String;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EquipmentConstraintsModeInfo = EquipmentConstraintsModeInfo(param2);
      this.codec_index.encode(param1,local3.index);
      this.codec_mode.encode(param1,local3.mode);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
