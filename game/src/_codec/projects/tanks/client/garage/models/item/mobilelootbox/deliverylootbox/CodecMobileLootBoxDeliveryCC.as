package _codec.projects.tanks.client.garage.models.item.mobilelootbox.deliverylootbox {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.mobilelootbox.deliverylootbox.MobileLootBoxDeliveryCC;

  public class CodecMobileLootBoxDeliveryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_periodOfGiveLootBoxInMin:ICodec;
    private var codec_remainingTimeToGiveLootBoxInSec:ICodec;

    public function CodecMobileLootBoxDeliveryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_periodOfGiveLootBoxInMin = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_remainingTimeToGiveLootBoxInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MobileLootBoxDeliveryCC = new MobileLootBoxDeliveryCC();
      local2.periodOfGiveLootBoxInMin = this.codec_periodOfGiveLootBoxInMin.decode(param1) as int;
      local2.remainingTimeToGiveLootBoxInSec = this.codec_remainingTimeToGiveLootBoxInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MobileLootBoxDeliveryCC = MobileLootBoxDeliveryCC(param2);
      this.codec_periodOfGiveLootBoxInMin.encode(param1,local3.periodOfGiveLootBoxInMin);
      this.codec_remainingTimeToGiveLootBoxInSec.encode(param1,local3.remainingTimeToGiveLootBoxInSec);
    }
  }
}
