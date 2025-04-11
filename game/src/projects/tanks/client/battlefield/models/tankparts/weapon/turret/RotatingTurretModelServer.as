package projects.tanks.client.battlefield.models.tankparts.weapon.turret {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class RotatingTurretModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _updateId:Long = Long.getLong(136019789,1773777629);
    private var _update_clientTimeCodec:ICodec;
    private var _update_incarnationIdCodec:ICodec;
    private var _update_turretStateCommandCodec:ICodec;
    private var model:IModel;

    public function RotatingTurretModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._update_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._update_incarnationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._update_turretStateCommandCodec = this.protocol.getCodec(new TypeCodecInfo(TurretStateCommand,false));
    }

    public function update(param1:int, param2:int, param3:TurretStateCommand) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._update_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._update_incarnationIdCodec.encode(this.protocolBuffer,param2);
      this._update_turretStateCommandCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._updateId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
