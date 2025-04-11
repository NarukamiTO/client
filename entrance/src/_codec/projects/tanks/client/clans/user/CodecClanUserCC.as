package _codec.projects.tanks.client.clans.user {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.clans.user.ClanUserCC;

  public class CodecClanUserCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_clan:ICodec;
    private var codec_giveBonusesClan:ICodec;
    private var codec_loadingInServiceSpace:ICodec;
    private var codec_restrictionTimeJoinClanInSec:ICodec;
    private var codec_showBuyLicenseButton:ICodec;
    private var codec_showOtherClan:ICodec;

    public function CodecClanUserCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_clan = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_giveBonusesClan = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_loadingInServiceSpace = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_restrictionTimeJoinClanInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_showBuyLicenseButton = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_showOtherClan = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanUserCC = new ClanUserCC();
      local2.clan = this.codec_clan.decode(param1) as Boolean;
      local2.giveBonusesClan = this.codec_giveBonusesClan.decode(param1) as Boolean;
      local2.loadingInServiceSpace = this.codec_loadingInServiceSpace.decode(param1) as Boolean;
      local2.restrictionTimeJoinClanInSec = this.codec_restrictionTimeJoinClanInSec.decode(param1) as int;
      local2.showBuyLicenseButton = this.codec_showBuyLicenseButton.decode(param1) as Boolean;
      local2.showOtherClan = this.codec_showOtherClan.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanUserCC = ClanUserCC(param2);
      this.codec_clan.encode(param1,local3.clan);
      this.codec_giveBonusesClan.encode(param1,local3.giveBonusesClan);
      this.codec_loadingInServiceSpace.encode(param1,local3.loadingInServiceSpace);
      this.codec_restrictionTimeJoinClanInSec.encode(param1,local3.restrictionTimeJoinClanInSec);
      this.codec_showBuyLicenseButton.encode(param1,local3.showBuyLicenseButton);
      this.codec_showOtherClan.encode(param1,local3.showOtherClan);
    }
  }
}
