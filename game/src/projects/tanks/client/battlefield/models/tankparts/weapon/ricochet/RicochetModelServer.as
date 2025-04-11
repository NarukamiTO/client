package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
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

  public class RicochetModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _fireCommandId:Long = Long.getLong(1356868511,460931703);
    private var _fireCommand_clientTimeCodec:ICodec;
    private var _fireCommand_shotIdCodec:ICodec;
    private var _fireCommand_shotDirectionXCodec:ICodec;
    private var _fireCommand_shotDirectionYCodec:ICodec;
    private var _fireCommand_shotDirectionZCodec:ICodec;
    private var _fireDummyCommandId:Long = Long.getLong(1432853658,-446317051);
    private var _fireDummyCommand_clientTimeCodec:ICodec;
    private var _hitStaticCommandId:Long = Long.getLong(1659660949,-434756778);
    private var _hitStaticCommand_clientTimeCodec:ICodec;
    private var _hitStaticCommand_shotIdCodec:ICodec;
    private var _hitStaticCommand_impactPointsCodec:ICodec;
    private var _hitTargetCommandId:Long = Long.getLong(1733814889,1388397267);
    private var _hitTargetCommand_clientTimeCodec:ICodec;
    private var _hitTargetCommand_targetCodec:ICodec;
    private var _hitTargetCommand_shotIdCodec:ICodec;
    private var _hitTargetCommand_targetPositionCodec:ICodec;
    private var _hitTargetCommand_impactPointsCodec:ICodec;
    private var model:IModel;

    public function RicochetModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._fireCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireCommand_shotDirectionXCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fireCommand_shotDirectionYCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fireCommand_shotDirectionZCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fireDummyCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitStaticCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitStaticCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitStaticCommand_impactPointsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
      this._hitTargetCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._hitTargetCommand_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._hitTargetCommand_impactPointsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
    }

    public function fireCommand(param1:int, param2:int, param3:int, param4:int, param5:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._fireCommand_shotIdCodec.encode(this.protocolBuffer,param2);
      this._fireCommand_shotDirectionXCodec.encode(this.protocolBuffer,param3);
      this._fireCommand_shotDirectionYCodec.encode(this.protocolBuffer,param4);
      this._fireCommand_shotDirectionZCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._fireCommandId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }

    public function fireDummyCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireDummyCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._fireDummyCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function hitStaticCommand(param1:int, param2:int, param3:Vector.<Vector3d>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._hitStaticCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._hitStaticCommand_shotIdCodec.encode(this.protocolBuffer,param2);
      this._hitStaticCommand_impactPointsCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._hitStaticCommandId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function hitTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector.<Vector3d>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._hitTargetCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._hitTargetCommand_targetCodec.encode(this.protocolBuffer,param2);
      this._hitTargetCommand_shotIdCodec.encode(this.protocolBuffer,param3);
      this._hitTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param4);
      this._hitTargetCommand_impactPointsCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._hitTargetCommandId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
