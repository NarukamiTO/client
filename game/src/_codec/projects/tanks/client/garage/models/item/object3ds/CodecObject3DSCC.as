package _codec.projects.tanks.client.garage.models.item.object3ds {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.garage.models.item.object3ds.Object3DSCC;

  public class CodecObject3DSCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_resourceId:ICodec;

    public function CodecObject3DSCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_resourceId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Object3DSCC = new Object3DSCC();
      local2.resourceId = this.codec_resourceId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Object3DSCC = Object3DSCC(param2);
      this.codec_resourceId.encode(param1,local3.resourceId);
    }
  }
}
