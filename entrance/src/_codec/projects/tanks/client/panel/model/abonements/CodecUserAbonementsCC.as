package _codec.projects.tanks.client.panel.model.abonements {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.abonements.ShopAbonementData;
  import projects.tanks.client.panel.model.abonements.UserAbonementsCC;

  public class CodecUserAbonementsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_abonementDataList:ICodec;

    public function CodecUserAbonementsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_abonementDataList = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ShopAbonementData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserAbonementsCC = new UserAbonementsCC();
      local2.abonementDataList = this.codec_abonementDataList.decode(param1) as Vector.<ShopAbonementData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserAbonementsCC = UserAbonementsCC(param2);
      this.codec_abonementDataList.encode(param1,local3.abonementDataList);
    }
  }
}
