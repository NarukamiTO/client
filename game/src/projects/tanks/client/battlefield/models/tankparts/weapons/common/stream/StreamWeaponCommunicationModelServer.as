package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class StreamWeaponCommunicationModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _startFireId:Long = Long.getLong(1600977732,-1971270444);
    private var _startFire_clientTimeCodec:ICodec;
    private var _stopFireId:Long = Long.getLong(779639549,-508617372);
    private var _stopFire_clientTimeCodec:ICodec;
    private var _updateTargetsId:Long = Long.getLong(1983735305,-731019411);
    private var _updateTargets_clientTimeCodec:ICodec;
    private var _updateTargets_directionCodec:ICodec;
    private var _updateTargets_targetsCodec:ICodec;
    private var _updateTargetsDummyId:Long = Long.getLong(116946402,65284411);
    private var _updateTargetsDummy_clientTimeCodec:ICodec;
    private var _updateTargetsDummy_directionCodec:ICodec;
    private var model:IModel;

    public function StreamWeaponCommunicationModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._startFire_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._stopFire_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateTargets_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateTargets_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._updateTargets_targetsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetPosition,false),false,1));
      this._updateTargetsDummy_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateTargetsDummy_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function startFire(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._startFire_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._startFireId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function stopFire(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._stopFire_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._stopFireId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function updateTargets(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._updateTargets_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._updateTargets_directionCodec.encode(this.protocolBuffer,param2);
      this._updateTargets_targetsCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._updateTargetsId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function updateTargetsDummy(param1:int, param2:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._updateTargetsDummy_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._updateTargetsDummy_directionCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._updateTargetsDummyId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
