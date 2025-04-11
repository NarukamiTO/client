package projects.tanks.client.battlefield.models.tankparts.weapon.railgun {
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

  public class RailgunModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _fireCommandId:Long = Long.getLong(448278927,-679337769);
    private var _fireCommand_clientTimeCodec:ICodec;
    private var _fireCommand_staticHitPointCodec:ICodec;
    private var _fireCommand_targetsCodec:ICodec;
    private var _fireCommand_targetHitPointsCodec:ICodec;
    private var _fireCommand_targetIncarnationsCodec:ICodec;
    private var _fireCommand_targetPositionsCodec:ICodec;
    private var _fireCommand_hitPointsWorldCodec:ICodec;
    private var _fireDummyCommandId:Long = Long.getLong(1791455660,457007003);
    private var _fireDummyCommand_clientTimeCodec:ICodec;
    private var _startChargingCommandId:Long = Long.getLong(747256245,1216344676);
    private var _startChargingCommand_timeCodec:ICodec;
    private var model:IModel;

    public function RailgunModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._fireCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireCommand_staticHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._fireCommand_targetsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1));
      this._fireCommand_targetHitPointsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._fireCommand_targetIncarnationsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,1));
      this._fireCommand_targetPositionsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._fireCommand_hitPointsWorldCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._fireDummyCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._startChargingCommand_timeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function fireCommand(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._fireCommand_staticHitPointCodec.encode(this.protocolBuffer,param2);
      this._fireCommand_targetsCodec.encode(this.protocolBuffer,param3);
      this._fireCommand_targetHitPointsCodec.encode(this.protocolBuffer,param4);
      this._fireCommand_targetIncarnationsCodec.encode(this.protocolBuffer,param5);
      this._fireCommand_targetPositionsCodec.encode(this.protocolBuffer,param6);
      this._fireCommand_hitPointsWorldCodec.encode(this.protocolBuffer,param7);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local8:SpaceCommand = new SpaceCommand(Model.object.id,this._fireCommandId,this.protocolBuffer);
      var local9:IGameObject = Model.object;
      var local10:ISpace = local9.space;
      local10.commandSender.sendCommand(local8);
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

    public function startChargingCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._startChargingCommand_timeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._startChargingCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
