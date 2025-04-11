package projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower {
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

  public class FlameThrowerModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _dryShotId:Long = Long.getLong(39687898,-187600281);
    private var _dryShot_timeCodec:ICodec;
    private var _hitCommandId:Long = Long.getLong(1226168606,1892142748);
    private var _hitCommand_timeCodec:ICodec;
    private var _hitCommand_targetsCodec:ICodec;
    private var _hitCommand_incarnationsCodec:ICodec;
    private var _hitCommand_targetPositionsCodec:ICodec;
    private var _hitCommand_hitPointsWorldCodec:ICodec;
    private var _startFireCommandId:Long = Long.getLong(36271653,-1590968991);
    private var _startFireCommand_timeCodec:ICodec;
    private var _stopFireCommandId:Long = Long.getLong(744810110,-807135961);
    private var _stopFireCommand_timeCodec:ICodec;
    private var model:IModel;

    public function FlameThrowerModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._dryShot_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._hitCommand_targetsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._hitCommand_incarnationsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),false,1));
      this._hitCommand_targetPositionsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
      this._hitCommand_hitPointsWorldCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
      this._startFireCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._stopFireCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function dryShot(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._dryShot_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._dryShotId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function hitCommand(param1:int, param2:Vector.<IGameObject>, param3:Vector.<int>, param4:Vector.<Vector3d>, param5:Vector.<Vector3d>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._hitCommand_timeCodec.encode(this.protocolBuffer,param1);
      this._hitCommand_targetsCodec.encode(this.protocolBuffer,param2);
      this._hitCommand_incarnationsCodec.encode(this.protocolBuffer,param3);
      this._hitCommand_targetPositionsCodec.encode(this.protocolBuffer,param4);
      this._hitCommand_hitPointsWorldCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._hitCommandId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }

    public function startFireCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._startFireCommand_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._startFireCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function stopFireCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._stopFireCommand_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._stopFireCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
