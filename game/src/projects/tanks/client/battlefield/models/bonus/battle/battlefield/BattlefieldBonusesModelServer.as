package projects.tanks.client.battlefield.models.bonus.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class BattlefieldBonusesModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _attemptToTakeBonusId:Long = Long.getLong(1669375812,-973745790);
    private var _attemptToTakeBonus_bonusIdCodec:ICodec;
    private var model:IModel;

    public function BattlefieldBonusesModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._attemptToTakeBonus_bonusIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function attemptToTakeBonus(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._attemptToTakeBonus_bonusIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._attemptToTakeBonusId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
