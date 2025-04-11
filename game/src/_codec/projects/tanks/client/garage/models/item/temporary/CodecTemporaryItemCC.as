package _codec.projects.tanks.client.garage.models.item.temporary {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.temporary.TemporaryItemCC;

  public class CodecTemporaryItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_infinityLifetimeItem:ICodec;
    private var codec_lifeTimeInSec:ICodec;
    private var codec_remainingTimeInSec:ICodec;

    public function CodecTemporaryItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_infinityLifetimeItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_lifeTimeInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_remainingTimeInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TemporaryItemCC = new TemporaryItemCC();
      local2.infinityLifetimeItem = this.codec_infinityLifetimeItem.decode(param1) as Boolean;
      local2.lifeTimeInSec = this.codec_lifeTimeInSec.decode(param1) as int;
      local2.remainingTimeInSec = this.codec_remainingTimeInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TemporaryItemCC = TemporaryItemCC(param2);
      this.codec_infinityLifetimeItem.encode(param1,local3.infinityLifetimeItem);
      this.codec_lifeTimeInSec.encode(param1,local3.lifeTimeInSec);
      this.codec_remainingTimeInSec.encode(param1,local3.remainingTimeInSec);
    }
  }
}
