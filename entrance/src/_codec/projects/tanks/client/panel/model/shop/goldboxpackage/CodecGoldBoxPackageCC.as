package _codec.projects.tanks.client.panel.model.shop.goldboxpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.goldboxpackage.GoldBoxPackageCC;

  public class CodecGoldBoxPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;

    public function CodecGoldBoxPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GoldBoxPackageCC = new GoldBoxPackageCC();
      local2.count = this.codec_count.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GoldBoxPackageCC = GoldBoxPackageCC(param2);
      this.codec_count.encode(param1,local3.count);
    }
  }
}
