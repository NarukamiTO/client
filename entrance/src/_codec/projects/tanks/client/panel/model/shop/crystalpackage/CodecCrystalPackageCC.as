package _codec.projects.tanks.client.panel.model.shop.crystalpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.crystalpackage.CrystalPackageCC;

  public class CodecCrystalPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonusCrystals:ICodec;
    private var codec_crystals:ICodec;
    private var codec_premiumDurationInDays:ICodec;

    public function CodecCrystalPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonusCrystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_crystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_premiumDurationInDays = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CrystalPackageCC = new CrystalPackageCC();
      local2.bonusCrystals = this.codec_bonusCrystals.decode(param1) as int;
      local2.crystals = this.codec_crystals.decode(param1) as int;
      local2.premiumDurationInDays = this.codec_premiumDurationInDays.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CrystalPackageCC = CrystalPackageCC(param2);
      this.codec_bonusCrystals.encode(param1,local3.bonusCrystals);
      this.codec_crystals.encode(param1,local3.crystals);
      this.codec_premiumDurationInDays.encode(param1,local3.premiumDurationInDays);
    }
  }
}
