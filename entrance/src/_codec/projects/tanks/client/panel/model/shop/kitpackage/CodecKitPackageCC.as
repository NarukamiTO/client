package _codec.projects.tanks.client.panel.model.shop.kitpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageCC;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  public class CodecKitPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_itemInfos:ICodec;
    private var codec_name:ICodec;
    private var codec_showDetails:ICodec;

    public function CodecKitPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_itemInfos = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(KitPackageItemInfo,false),false,1));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_showDetails = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitPackageCC = new KitPackageCC();
      local2.itemInfos = this.codec_itemInfos.decode(param1) as Vector.<KitPackageItemInfo>;
      local2.name = this.codec_name.decode(param1) as String;
      local2.showDetails = this.codec_showDetails.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitPackageCC = KitPackageCC(param2);
      this.codec_itemInfos.encode(param1,local3.itemInfos);
      this.codec_name.encode(param1,local3.name);
      this.codec_showDetails.encode(param1,local3.showDetails);
    }
  }
}
