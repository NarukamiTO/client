package _codec.projects.tanks.client.panel.model.referrals {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;

  public class CodecReferralIncomeData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_income:ICodec;
    private var codec_user:ICodec;

    public function CodecReferralIncomeData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_income = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_user = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ReferralIncomeData = new ReferralIncomeData();
      local2.income = this.codec_income.decode(param1) as int;
      local2.user = this.codec_user.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ReferralIncomeData = ReferralIncomeData(param2);
      this.codec_income.encode(param1,local3.income);
      this.codec_user.encode(param1,local3.user);
    }
  }
}
