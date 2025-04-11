package _codec.projects.tanks.client.clans.panel.notification {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.clans.panel.notification.ClanPanelNotificationCC;

  public class CodecClanPanelNotificationCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_numberNotifications:ICodec;
    private var codec_restrictionTimeJoinClanInSec:ICodec;

    public function CodecClanPanelNotificationCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_numberNotifications = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_restrictionTimeJoinClanInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanPanelNotificationCC = new ClanPanelNotificationCC();
      local2.numberNotifications = this.codec_numberNotifications.decode(param1) as int;
      local2.restrictionTimeJoinClanInSec = this.codec_restrictionTimeJoinClanInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanPanelNotificationCC = ClanPanelNotificationCC(param2);
      this.codec_numberNotifications.encode(param1,local3.numberNotifications);
      this.codec_restrictionTimeJoinClanInSec.encode(param1,local3.restrictionTimeJoinClanInSec);
    }
  }
}
