package _codec.projects.tanks.client.garage.models.item.droppablegold {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.droppablegold.DroppableGoldItemCC;

  public class CodecDroppableGoldItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_showDroppableGoldAuthor:ICodec;

    public function CodecDroppableGoldItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_showDroppableGoldAuthor = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DroppableGoldItemCC = new DroppableGoldItemCC();
      local2.showDroppableGoldAuthor = this.codec_showDroppableGoldAuthor.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DroppableGoldItemCC = DroppableGoldItemCC(param2);
      this.codec_showDroppableGoldAuthor.encode(param1,local3.showDroppableGoldAuthor);
    }
  }
}
