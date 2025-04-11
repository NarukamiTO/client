package projects.tanks.client.battlefield.models.tankparts.weapon.healing {
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
  import projects.tanks.client.battlefield.types.Vector3d;

  public class IsisModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _resetTargetId:Long = Long.getLong(315477850,74416950);
    private var _resetTarget_timeCodec:ICodec;
    private var _setTargetId:Long = Long.getLong(724350021,-1874612855);
    private var _setTarget_timeCodec:ICodec;
    private var _setTarget_targetCodec:ICodec;
    private var _setTarget_targetIncarnationCodec:ICodec;
    private var _setTarget_localHitPointCodec:ICodec;
    private var _stopWeaponCommandId:Long = Long.getLong(2132283949,89958307);
    private var _stopWeaponCommand_timeCodec:ICodec;
    private var _tickCommandId:Long = Long.getLong(315880994,956762724);
    private var _tickCommand_timeCodec:ICodec;
    private var _tickCommand_targetIncarnationCodec:ICodec;
    private var _tickCommand_targetPositionCodec:ICodec;
    private var _tickCommand_localHitPointCodec:ICodec;
    private var model:IModel;

    public function IsisModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._resetTarget_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._setTarget_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._setTarget_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._setTarget_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._setTarget_localHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._stopWeaponCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tickCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tickCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._tickCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._tickCommand_localHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function resetTarget(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._resetTarget_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._resetTargetId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function setTarget(param1:int, param2:IGameObject, param3:int, param4:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._setTarget_timeCodec.encode(this.protocolBuffer,param1);
      this._setTarget_targetCodec.encode(this.protocolBuffer,param2);
      this._setTarget_targetIncarnationCodec.encode(this.protocolBuffer,param3);
      this._setTarget_localHitPointCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._setTargetId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }

    public function stopWeaponCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._stopWeaponCommand_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._stopWeaponCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function tickCommand(param1:int, param2:int, param3:Vector3d, param4:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tickCommand_timeCodec.encode(this.protocolBuffer,param1);
      this._tickCommand_targetIncarnationCodec.encode(this.protocolBuffer,param2);
      this._tickCommand_targetPositionCodec.encode(this.protocolBuffer,param3);
      this._tickCommand_localHitPointCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._tickCommandId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
