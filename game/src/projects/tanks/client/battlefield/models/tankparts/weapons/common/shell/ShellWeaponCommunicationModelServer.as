package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ShellWeaponCommunicationModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _tryToDummyShootId:Long = Long.getLong(1416574450,1036034301);
    private var _tryToDummyShoot_clientTimeCodec:ICodec;
    private var _tryToDummyShoot_barrelIndexCodec:ICodec;
    private var _tryToHitId:Long = Long.getLong(1345782104,505677395);
    private var _tryToHit_clientTimeCodec:ICodec;
    private var _tryToHit_shellHitCodec:ICodec;
    private var _tryToShootId:Long = Long.getLong(511445961,614544455);
    private var _tryToShoot_clientTimeCodec:ICodec;
    private var _tryToShoot_barrelIndexCodec:ICodec;
    private var _tryToShoot_shotIdCodec:ICodec;
    private var _tryToShoot_directionCodec:ICodec;
    private var _tryToShootWithTargetId:Long = Long.getLong(1961620998,1436748144);
    private var _tryToShootWithTarget_clientTimeCodec:ICodec;
    private var _tryToShootWithTarget_barrelIndexCodec:ICodec;
    private var _tryToShootWithTarget_shotIdCodec:ICodec;
    private var _tryToShootWithTarget_directionCodec:ICodec;
    private var _tryToShootWithTarget_targetCodec:ICodec;
    private var _tryToShootWithTarget_localTargetPointCodec:ICodec;
    private var model:IModel;

    public function ShellWeaponCommunicationModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._tryToDummyShoot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToDummyShoot_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._tryToHit_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToHit_shellHitCodec = this.protocol.getCodec(new TypeCodecInfo(ShellHit,false));
      this._tryToShoot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToShoot_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._tryToShoot_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToShoot_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._tryToShootWithTarget_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToShootWithTarget_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(Byte,false));
      this._tryToShootWithTarget_shotIdCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._tryToShootWithTarget_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._tryToShootWithTarget_targetCodec = this.protocol.getCodec(new TypeCodecInfo(TargetPosition,false));
      this._tryToShootWithTarget_localTargetPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function tryToDummyShoot(param1:int, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToDummyShoot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToDummyShoot_barrelIndexCodec.encode(this.protocolBuffer,param2);
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

    public function tryToHit(param1:int, param2:ShellHit) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToHit_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToHit_shellHitCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._tryToHitId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToShoot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToShoot_barrelIndexCodec.encode(this.protocolBuffer,param2);
      this._tryToShoot_shotIdCodec.encode(this.protocolBuffer,param3);
      this._tryToShoot_directionCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._tryToShootId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }

    public function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3d, param5:TargetPosition, param6:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._tryToShootWithTarget_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._tryToShootWithTarget_barrelIndexCodec.encode(this.protocolBuffer,param2);
      this._tryToShootWithTarget_shotIdCodec.encode(this.protocolBuffer,param3);
      this._tryToShootWithTarget_directionCodec.encode(this.protocolBuffer,param4);
      this._tryToShootWithTarget_targetCodec.encode(this.protocolBuffer,param5);
      this._tryToShootWithTarget_localTargetPointCodec.encode(this.protocolBuffer,param6);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local7:SpaceCommand = new SpaceCommand(Model.object.id,this._tryToShootWithTargetId,this.protocolBuffer);
      var local8:IGameObject = Model.object;
      var local9:ISpace = local8.space;
      local9.commandSender.sendCommand(local7);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
