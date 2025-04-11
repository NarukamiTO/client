package projects.tanks.client.battlefield.models.tankparts.weapon.terminator {
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

  public class TerminatorModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _primaryChargeId:Long = Long.getLong(599352190,701324778);
    private var _primaryCharge_clientTimeCodec:ICodec;
    private var _primaryCharge_barrelIndexCodec:ICodec;
    private var _primaryDummyShotId:Long = Long.getLong(1122047966,-542035764);
    private var _primaryDummyShot_clientTimeCodec:ICodec;
    private var _primaryDummyShot_barrelIndexCodec:ICodec;
    private var _primaryShotId:Long = Long.getLong(1697698460,1026724944);
    private var _primaryShot_clientTimeCodec:ICodec;
    private var _primaryShot_staticHitPointCodec:ICodec;
    private var _primaryShot_targetsCodec:ICodec;
    private var _primaryShot_targetHitPointsCodec:ICodec;
    private var _primaryShot_targetIncarnationsCodec:ICodec;
    private var _primaryShot_targetPositionsCodec:ICodec;
    private var _primaryShot_hitPointsWorldCodec:ICodec;
    private var _primaryShot_barrelIndexCodec:ICodec;
    private var _secondaryHideId:Long = Long.getLong(1071491744,825439082);
    private var _secondaryHide_clientTimeCodec:ICodec;
    private var _secondaryOpenId:Long = Long.getLong(1071491744,825654386);
    private var _secondaryOpen_clientTimeCodec:ICodec;
    private var model:IModel;

    public function TerminatorModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._primaryCharge_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryCharge_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryDummyShot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryDummyShot_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryShot_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._primaryShot_staticHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,true));
      this._primaryShot_targetsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1));
      this._primaryShot_targetHitPointsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._primaryShot_targetIncarnationsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,1));
      this._primaryShot_targetPositionsCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._primaryShot_hitPointsWorldCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),true,1));
      this._primaryShot_barrelIndexCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._secondaryHide_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._secondaryOpen_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function primaryCharge(param1:int, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryCharge_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryCharge_barrelIndexCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryChargeId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function primaryDummyShot(param1:int, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryDummyShot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryDummyShot_barrelIndexCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryDummyShotId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function primaryShot(param1:int, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:Vector.<int>, param6:Vector.<Vector3d>, param7:Vector.<Vector3d>, param8:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._primaryShot_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._primaryShot_staticHitPointCodec.encode(this.protocolBuffer,param2);
      this._primaryShot_targetsCodec.encode(this.protocolBuffer,param3);
      this._primaryShot_targetHitPointsCodec.encode(this.protocolBuffer,param4);
      this._primaryShot_targetIncarnationsCodec.encode(this.protocolBuffer,param5);
      this._primaryShot_targetPositionsCodec.encode(this.protocolBuffer,param6);
      this._primaryShot_hitPointsWorldCodec.encode(this.protocolBuffer,param7);
      this._primaryShot_barrelIndexCodec.encode(this.protocolBuffer,param8);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local9:SpaceCommand = new SpaceCommand(Model.object.id,this._primaryShotId,this.protocolBuffer);
      var local10:IGameObject = Model.object;
      var local11:ISpace = local10.space;
      local11.commandSender.sendCommand(local9);
      this.protocolBuffer.optionalMap.clear();
    }

    public function secondaryHide(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._secondaryHide_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._secondaryHideId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function secondaryOpen(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._secondaryOpen_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._secondaryOpenId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
