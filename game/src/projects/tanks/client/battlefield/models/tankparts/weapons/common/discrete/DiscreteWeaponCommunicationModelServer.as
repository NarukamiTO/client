package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete {
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

  public class DiscreteWeaponCommunicationModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _tryToDummyShootId:Long = Long.getLong(854040669,-100146847);
    private var _tryToDummyShoot_clientTimeCodec:ICodec;
    private var _tryToDummyShoot_directionCodec:ICodec;
    private var _tryToShootId:Long = Long.getLong(2115177320,1289626411);
    private var _tryToShoot_clientTimeCodec:ICodec;
    private var _tryToShoot_directionCodec:ICodec;
    private var _tryToShoot_targetsCodec:ICodec;
    private var model:IModel;

    public function DiscreteWeaponCommunicationModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._tryToDummyShoot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToDummyShoot_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._tryToShoot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToShoot_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._tryToShoot_targetsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetPosition,false),false,1));
    }

    public function tryToDummyShoot(param1:int, param2:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToDummyShoot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToDummyShoot_directionCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._tryToDummyShootId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function tryToShoot(param1:int, param2:Vector3d, param3:Vector.<TargetPosition>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToShoot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToShoot_directionCodec.encode(this.protocolBuffer,param2);
      this._tryToShoot_targetsCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._tryToShootId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
