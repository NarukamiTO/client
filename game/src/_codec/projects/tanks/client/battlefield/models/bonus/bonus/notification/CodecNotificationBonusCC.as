package _codec.projects.tanks.client.battlefield.models.bonus.bonus.notification {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.notification.NotificationBonusCC;

  public class CodecNotificationBonusCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_notificationMessage:ICodec;
    private var codec_notificationMessageContainsUid:ICodec;
    private var codec_soundNotification:ICodec;

    public function CodecNotificationBonusCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_notificationMessage = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_notificationMessageContainsUid = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_soundNotification = param1.getCodec(new TypeCodecInfo(SoundResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:NotificationBonusCC = new NotificationBonusCC();
      local2.notificationMessage = this.codec_notificationMessage.decode(param1) as String;
      local2.notificationMessageContainsUid = this.codec_notificationMessageContainsUid.decode(param1) as String;
      local2.soundNotification = this.codec_soundNotification.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:NotificationBonusCC = NotificationBonusCC(param2);
      this.codec_notificationMessage.encode(param1,local3.notificationMessage);
      this.codec_notificationMessageContainsUid.encode(param1,local3.notificationMessageContainsUid);
      this.codec_soundNotification.encode(param1,local3.soundNotification);
    }
  }
}
