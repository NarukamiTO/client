package _codec.projects.tanks.client.panel.model.premiumaccount.alert {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.panel.model.premiumaccount.alert.PremiumAccountAlertCC;

  public class CodecPremiumAccountAlertCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_localRuntimeUser:ICodec;
    private var codec_needShowNotificationCompletionPremium:ICodec;
    private var codec_needShowWelcomeAlert:ICodec;
    private var codec_reminderCompletionPremiumTime:ICodec;
    private var codec_wasShowAlertForFirstPurchasePremium:ICodec;
    private var codec_wasShowReminderCompletionPremium:ICodec;

    public function CodecPremiumAccountAlertCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_localRuntimeUser = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_needShowNotificationCompletionPremium = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_needShowWelcomeAlert = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_reminderCompletionPremiumTime = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_wasShowAlertForFirstPurchasePremium = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_wasShowReminderCompletionPremium = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PremiumAccountAlertCC = new PremiumAccountAlertCC();
      local2.localRuntimeUser = this.codec_localRuntimeUser.decode(param1) as Boolean;
      local2.needShowNotificationCompletionPremium = this.codec_needShowNotificationCompletionPremium.decode(param1) as Boolean;
      local2.needShowWelcomeAlert = this.codec_needShowWelcomeAlert.decode(param1) as Boolean;
      local2.reminderCompletionPremiumTime = this.codec_reminderCompletionPremiumTime.decode(param1) as Number;
      local2.wasShowAlertForFirstPurchasePremium = this.codec_wasShowAlertForFirstPurchasePremium.decode(param1) as Boolean;
      local2.wasShowReminderCompletionPremium = this.codec_wasShowReminderCompletionPremium.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PremiumAccountAlertCC = PremiumAccountAlertCC(param2);
      this.codec_localRuntimeUser.encode(param1,local3.localRuntimeUser);
      this.codec_needShowNotificationCompletionPremium.encode(param1,local3.needShowNotificationCompletionPremium);
      this.codec_needShowWelcomeAlert.encode(param1,local3.needShowWelcomeAlert);
      this.codec_reminderCompletionPremiumTime.encode(param1,local3.reminderCompletionPremiumTime);
      this.codec_wasShowAlertForFirstPurchasePremium.encode(param1,local3.wasShowAlertForFirstPurchasePremium);
      this.codec_wasShowReminderCompletionPremium.encode(param1,local3.wasShowReminderCompletionPremium);
    }
  }
}
