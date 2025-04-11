package _codec.projects.tanks.client.garage.skins {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.skins.MountedSkinCC;

  public class CodecMountedSkinCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_item:ICodec;

    public function CodecMountedSkinCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_item = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MountedSkinCC = new MountedSkinCC();
      local2.item = this.codec_item.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MountedSkinCC = MountedSkinCC(param2);
      this.codec_item.encode(param1,local3.item);
    }
  }
}
