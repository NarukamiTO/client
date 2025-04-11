package _codec.projects.tanks.client.garage.models.item.resistance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.resistance.MountedResistancesCC;

  public class CodecMountedResistancesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_resistances:ICodec;

    public function CodecMountedResistancesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_resistances = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MountedResistancesCC = new MountedResistancesCC();
      local2.resistances = this.codec_resistances.decode(param1) as Vector.<IGameObject>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MountedResistancesCC = MountedResistancesCC(param2);
      this.codec_resistances.encode(param1,local3.resistances);
    }
  }
}
