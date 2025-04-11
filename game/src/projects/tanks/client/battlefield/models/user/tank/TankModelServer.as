package projects.tanks.client.battlefield.models.user.tank {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;

  public class TankModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _deathConfirmationCommandId:Long = Long.getLong(674088239,-466180297);
    private var _handleCollisionWithOtherTankId:Long = Long.getLong(27305946,689085087);
    private var _handleCollisionWithOtherTank_otherTankZVelocityCodec:ICodec;
    private var _moveCommandId:Long = Long.getLong(2114337908,577714981);
    private var _moveCommand_clientTimeCodec:ICodec;
    private var _moveCommand_specificationIdCodec:ICodec;
    private var _moveCommand_moveCommandCodec:ICodec;
    private var _movementControlCommandId:Long = Long.getLong(1028282615,1943158798);
    private var _movementControlCommand_clientTimeCodec:ICodec;
    private var _movementControlCommand_specificationIdCodec:ICodec;
    private var _movementControlCommand_controlCodec:ICodec;
    private var _movementControlCommand_turnSpeedNumberCodec:ICodec;
    private var model:IModel;

    public function TankModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._handleCollisionWithOtherTank_otherTankZVelocityCodec = this.protocol.getCodec(new TypeCodecInfo(Float,false));
      this._moveCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._moveCommand_specificationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._moveCommand_moveCommandCodec = this.protocol.getCodec(new TypeCodecInfo(MoveCommand,false));
      this._movementControlCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._movementControlCommand_specificationIdCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._movementControlCommand_controlCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._movementControlCommand_turnSpeedNumberCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
    }

    public function deathConfirmationCommand() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._deathConfirmationCommandId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }

    public function handleCollisionWithOtherTank(param1:Number) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._handleCollisionWithOtherTank_otherTankZVelocityCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._handleCollisionWithOtherTankId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function moveCommand(param1:int, param2:int, param3:MoveCommand) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._moveCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._moveCommand_specificationIdCodec.encode(this.protocolBuffer,param2);
      this._moveCommand_moveCommandCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._moveCommandId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function movementControlCommand(param1:int, param2:int, param3:int, param4:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._movementControlCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._movementControlCommand_specificationIdCodec.encode(this.protocolBuffer,param2);
      this._movementControlCommand_controlCodec.encode(this.protocolBuffer,param3);
      this._movementControlCommand_turnSpeedNumberCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._movementControlCommandId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
