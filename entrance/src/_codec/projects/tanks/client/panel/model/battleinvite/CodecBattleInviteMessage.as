package _codec.projects.tanks.client.panel.model.battleinvite {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.battleinvite.BattleInviteMessage;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class CodecBattleInviteMessage implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_availableSlot:ICodec;
    private var codec_battleData:ICodec;

    public function CodecBattleInviteMessage() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_availableSlot = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_battleData = param1.getCodec(new TypeCodecInfo(BattleInfoData,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleInviteMessage = new BattleInviteMessage();
      local2.availableSlot = this.codec_availableSlot.decode(param1) as Boolean;
      local2.battleData = this.codec_battleData.decode(param1) as BattleInfoData;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleInviteMessage = BattleInviteMessage(param2);
      this.codec_availableSlot.encode(param1,local3.availableSlot);
      this.codec_battleData.encode(param1,local3.battleData);
    }
  }
}
