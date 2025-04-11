package projects.tanks.client.battlefield.models.tankparts.weapon.gauss {
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
  import projects.tanks.client.battlefield.types.Vector3d;

  public class GaussModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _dummyShotCommandId:Long = Long.getLong(1849472538,1291058021);
    private var _dummyShotCommand_clientTimeCodec:ICodec;
    private var _primaryHitStaticCommandId:Long = Long.getLong(922383116,1651838310);
    private var _primaryHitStaticCommand_clientTimeCodec:ICodec;
    private var _primaryHitStaticCommand_shotIdCodec:ICodec;
    private var _primaryHitStaticCommand_hitPointWorldCodec:ICodec;
    private var _primaryHitTargetCommandId:Long = Long.getLong(848229176,-171315735);
    private var _primaryHitTargetCommand_clientTimeCodec:ICodec;
    private var _primaryHitTargetCommand_shotIdCodec:ICodec;
    private var _primaryHitTargetCommand_targetCodec:ICodec;
    private var _primaryHitTargetCommand_targetPositionCodec:ICodec;
    private var _primaryHitTargetCommand_hitPointWorldCodec:ICodec;
    private var _primaryShotCommandId:Long = Long.getLong(693669628,-864971393);
    private var _primaryShotCommand_clientTimeCodec:ICodec;
    private var _primaryShotCommand_shotIdCodec:ICodec;
    private var _primaryShotCommand_shotDirectionCodec:ICodec;
    private var _secondaryHitTargetCommandId:Long = Long.getLong(128655614,-748587511);
    private var _secondaryHitTargetCommand_clientTimeCodec:ICodec;
    private var _secondaryHitTargetCommand_targetCodec:ICodec;
    private var _secondaryHitTargetCommand_targetPositionCodec:ICodec;
    private var _secondaryHitTargetCommand_localHitPositionCodec:ICodec;
    private var _secondaryHitTargetCommand_worldHitPositionCodec:ICodec;
    private var _startAimingId:Long = Long.getLong(1529985580,1009791181);
    private var _startAiming_clientTimeCodec:ICodec;
    private var _stopAimingId:Long = Long.getLong(603543791,36139025);
    private var _stopAiming_clientTimeCodec:ICodec;
    private var model:IModel;

    public function GaussModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._dummyShotCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryHitStaticCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryHitStaticCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryHitStaticCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._primaryHitTargetCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryHitTargetCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryHitTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._primaryHitTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._primaryHitTargetCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._primaryShotCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryShotCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryShotCommand_shotDirectionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._secondaryHitTargetCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._secondaryHitTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._secondaryHitTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._secondaryHitTargetCommand_localHitPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._secondaryHitTargetCommand_worldHitPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._startAiming_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._stopAiming_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function dummyShotCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._dummyShotCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._dummyShotCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function primaryHitStaticCommand(param1:int, param2:int, param3:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryHitStaticCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryHitStaticCommand_shotIdCodec.encode(this.protocolBuffer,param2);
      this._primaryHitStaticCommand_hitPointWorldCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryHitStaticCommandId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function primaryHitTargetCommand(param1:int, param2:int, param3:IGameObject, param4:Vector3d, param5:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryHitTargetCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryHitTargetCommand_shotIdCodec.encode(this.protocolBuffer,param2);
      this._primaryHitTargetCommand_targetCodec.encode(this.protocolBuffer,param3);
      this._primaryHitTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param4);
      this._primaryHitTargetCommand_hitPointWorldCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryHitTargetCommandId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }

    public function primaryShotCommand(param1:int, param2:int, param3:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryShotCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryShotCommand_shotIdCodec.encode(this.protocolBuffer,param2);
      this._primaryShotCommand_shotDirectionCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryShotCommandId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function secondaryHitTargetCommand(param1:int, param2:IGameObject, param3:Vector3d, param4:Vector3d, param5:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._secondaryHitTargetCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._secondaryHitTargetCommand_targetCodec.encode(this.protocolBuffer,param2);
      this._secondaryHitTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param3);
      this._secondaryHitTargetCommand_localHitPositionCodec.encode(this.protocolBuffer,param4);
      this._secondaryHitTargetCommand_worldHitPositionCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._secondaryHitTargetCommandId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }

    public function startAiming(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._startAiming_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._startAimingId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function stopAiming(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._stopAiming_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._stopAimingId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
