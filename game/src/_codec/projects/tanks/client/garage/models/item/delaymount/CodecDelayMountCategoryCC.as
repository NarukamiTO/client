package _codec.projects.tanks.client.garage.models.item.delaymount {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;

  public class CodecDelayMountCategoryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_delayMountArmorInSec:ICodec;
    private var codec_delayMountDroneInSec:ICodec;
    private var codec_delayMountResistanceInSec:ICodec;
    private var codec_delayMountWeaponInSec:ICodec;

    public function CodecDelayMountCategoryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_delayMountArmorInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_delayMountDroneInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_delayMountResistanceInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_delayMountWeaponInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DelayMountCategoryCC = new DelayMountCategoryCC();
      local2.delayMountArmorInSec = this.codec_delayMountArmorInSec.decode(param1) as int;
      local2.delayMountDroneInSec = this.codec_delayMountDroneInSec.decode(param1) as int;
      local2.delayMountResistanceInSec = this.codec_delayMountResistanceInSec.decode(param1) as int;
      local2.delayMountWeaponInSec = this.codec_delayMountWeaponInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DelayMountCategoryCC = DelayMountCategoryCC(param2);
      this.codec_delayMountArmorInSec.encode(param1,local3.delayMountArmorInSec);
      this.codec_delayMountDroneInSec.encode(param1,local3.delayMountDroneInSec);
      this.codec_delayMountResistanceInSec.encode(param1,local3.delayMountResistanceInSec);
      this.codec_delayMountWeaponInSec.encode(param1,local3.delayMountWeaponInSec);
    }
  }
}
