package projects.tanks.client.battlefield.models.tankparts.weapon.shaft {
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

  public class ShaftModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _activateManualTargetingCommandId:Long = Long.getLong(1850967873,1410393465);
    private var _aimedShotCommandId:Long = Long.getLong(665718601,863056095);
    private var _aimedShotCommand_timeCodec:ICodec;
    private var _aimedShotCommand_staticHitPointCodec:ICodec;
    private var _aimedShotCommand_targetCodec:ICodec;
    private var _aimedShotCommand_targetHitPointCodec:ICodec;
    private var _aimedShotCommand_targetIncarnationCodec:ICodec;
    private var _aimedShotCommand_targetPositionCodec:ICodec;
    private var _aimedShotCommand_hitPointWorldCodec:ICodec;
    private var _beginEnergyDrainCommandId:Long = Long.getLong(384666897,-1041026192);
    private var _beginEnergyDrainCommand_timeCodec:ICodec;
    private var _quickShotCommandId:Long = Long.getLong(1060379432,313263560);
    private var _quickShotCommand_timeCodec:ICodec;
    private var _quickShotCommand_staticHitPointCodec:ICodec;
    private var _quickShotCommand_targetCodec:ICodec;
    private var _quickShotCommand_targetHitPointCodec:ICodec;
    private var _quickShotCommand_targetIncarnationCodec:ICodec;
    private var _quickShotCommand_targetPositionCodec:ICodec;
    private var _quickShotCommand_hitPointWorldCodec:ICodec;
    private var _stopManualTargetingCommandId:Long = Long.getLong(717480200,-1898093994);
    private var model:IModel;

    public function ShaftModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._aimedShotCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._aimedShotCommand_staticHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._aimedShotCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      this._aimedShotCommand_targetHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._aimedShotCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._aimedShotCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._aimedShotCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._beginEnergyDrainCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._quickShotCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._quickShotCommand_staticHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._quickShotCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      this._quickShotCommand_targetHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._quickShotCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._quickShotCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._quickShotCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
    }

    public function activateManualTargetingCommand() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._activateManualTargetingCommandId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }

    public function aimedShotCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:int, param6:Vector3d, param7:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._aimedShotCommand_timeCodec.encode(this.protocolBuffer,param1);
      this._aimedShotCommand_staticHitPointCodec.encode(this.protocolBuffer,param2);
      this._aimedShotCommand_targetCodec.encode(this.protocolBuffer,param3);
      this._aimedShotCommand_targetHitPointCodec.encode(this.protocolBuffer,param4);
      this._aimedShotCommand_targetIncarnationCodec.encode(this.protocolBuffer,param5);
      this._aimedShotCommand_targetPositionCodec.encode(this.protocolBuffer,param6);
      this._aimedShotCommand_hitPointWorldCodec.encode(this.protocolBuffer,param7);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local8:SpaceCommand = new SpaceCommand(Model.object.id,this._aimedShotCommandId,this.protocolBuffer);
      var local9:IGameObject = Model.object;
      var local10:ISpace = local9.space;
      local10.commandSender.sendCommand(local8);
      this.protocolBuffer.optionalMap.clear();
    }

    public function beginEnergyDrainCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._beginEnergyDrainCommand_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._beginEnergyDrainCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function quickShotCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:int, param6:Vector3d, param7:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._quickShotCommand_timeCodec.encode(this.protocolBuffer,param1);
      this._quickShotCommand_staticHitPointCodec.encode(this.protocolBuffer,param2);
      this._quickShotCommand_targetCodec.encode(this.protocolBuffer,param3);
      this._quickShotCommand_targetHitPointCodec.encode(this.protocolBuffer,param4);
      this._quickShotCommand_targetIncarnationCodec.encode(this.protocolBuffer,param5);
      this._quickShotCommand_targetPositionCodec.encode(this.protocolBuffer,param6);
      this._quickShotCommand_hitPointWorldCodec.encode(this.protocolBuffer,param7);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local8:SpaceCommand = new SpaceCommand(Model.object.id,this._quickShotCommandId,this.protocolBuffer);
      var local9:IGameObject = Model.object;
      var local10:ISpace = local9.space;
      local10.commandSender.sendCommand(local8);
      this.protocolBuffer.optionalMap.clear();
    }

    public function stopManualTargetingCommand() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._stopManualTargetingCommandId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
