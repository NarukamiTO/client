package _codec.projects.tanks.client.panel.model.battleinvite {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.panel.model.battleinvite.BattleInviteCC;

  public class CodecBattleInviteCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_soundNotification:ICodec;

    public function CodecBattleInviteCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_soundNotification = param1.getCodec(new TypeCodecInfo(SoundResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleInviteCC = new BattleInviteCC();
      local2.soundNotification = this.codec_soundNotification.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleInviteCC = BattleInviteCC(param2);
      this.codec_soundNotification.encode(param1,local3.soundNotification);
    }
  }
}
