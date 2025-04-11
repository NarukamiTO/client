package _codec.projects.tanks.client.tanksservices.model.formatbattle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsCC;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsModeInfo;

  public class CodecEquipmentConstraintsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_equipmentConstraintsModeInfos:ICodec;

    public function CodecEquipmentConstraintsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_equipmentConstraintsModeInfos = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(EquipmentConstraintsModeInfo,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EquipmentConstraintsCC = new EquipmentConstraintsCC();
      local2.equipmentConstraintsModeInfos = this.codec_equipmentConstraintsModeInfos.decode(param1) as Vector.<EquipmentConstraintsModeInfo>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EquipmentConstraintsCC = EquipmentConstraintsCC(param2);
      this.codec_equipmentConstraintsModeInfos.encode(param1,local3.equipmentConstraintsModeInfos);
    }
  }
}
