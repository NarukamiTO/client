package _codec.projects.tanks.client.garage.models.item.videoads {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.videoads.VideoAdsItemUpgradeCC;

  public class CodecVideoAdsItemUpgradeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_cooldownTimeInSec:ICodec;
    private var codec_timeToReduceUpdateInMin:ICodec;

    public function CodecVideoAdsItemUpgradeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_cooldownTimeInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeToReduceUpdateInMin = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:VideoAdsItemUpgradeCC = new VideoAdsItemUpgradeCC();
      local2.cooldownTimeInSec = this.codec_cooldownTimeInSec.decode(param1) as int;
      local2.timeToReduceUpdateInMin = this.codec_timeToReduceUpdateInMin.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:VideoAdsItemUpgradeCC = VideoAdsItemUpgradeCC(param2);
      this.codec_cooldownTimeInSec.encode(param1,local3.cooldownTimeInSec);
      this.codec_timeToReduceUpdateInMin.encode(param1,local3.timeToReduceUpdateInMin);
    }
  }
}
