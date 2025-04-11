package projects.tanks.client.battlefield.models.tankparts.weapon.thunder {
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

  public class ThunderModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _shootCommandId:Long = Long.getLong(304771021,-505618508);
    private var _shootCommand_shotTimeCodec:ICodec;
    private var _shootStaticCommandId:Long = Long.getLong(119662358,318565694);
    private var _shootStaticCommand_shotTimeCodec:ICodec;
    private var _shootStaticCommand_directionCodec:ICodec;
    private var _shootTargetCommandId:Long = Long.getLong(193816297,2141719739);
    private var _shootTargetCommand_shotTimeCodec:ICodec;
    private var _shootTargetCommand_relativeHitPointCodec:ICodec;
    private var _shootTargetCommand_targetCodec:ICodec;
    private var _shootTargetCommand_targetIncarnationCodec:ICodec;
    private var _shootTargetCommand_targetPositionCodec:ICodec;
    private var _shootTargetCommand_hitPointWorldCodec:ICodec;
    private var model:IModel;

    public function ThunderModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._shootCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._shootStaticCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._shootStaticCommand_directionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTargetCommand_shotTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._shootTargetCommand_relativeHitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._shootTargetCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._shootTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._shootTargetCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function shootCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._shootCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._shootCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function shootStaticCommand(param1:int, param2:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._shootStaticCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
      this._shootStaticCommand_directionCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._shootStaticCommandId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function shootTargetCommand(param1:int, param2:Vector3d, param3:IGameObject, param4:int, param5:Vector3d, param6:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._shootTargetCommand_shotTimeCodec.encode(this.protocolBuffer,param1);
      this._shootTargetCommand_relativeHitPointCodec.encode(this.protocolBuffer,param2);
      this._shootTargetCommand_targetCodec.encode(this.protocolBuffer,param3);
      this._shootTargetCommand_targetIncarnationCodec.encode(this.protocolBuffer,param4);
      this._shootTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param5);
      this._shootTargetCommand_hitPointWorldCodec.encode(this.protocolBuffer,param6);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local7:SpaceCommand = new SpaceCommand(Model.object.id,this._shootTargetCommandId,this.protocolBuffer);
      var local8:IGameObject = Model.object;
      var local9:ISpace = local8.space;
      local9.commandSender.sendCommand(local7);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
