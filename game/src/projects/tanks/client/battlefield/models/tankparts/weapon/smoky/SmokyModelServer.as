package projects.tanks.client.battlefield.models.tankparts.weapon.smoky {
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

  public class SmokyModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _fireCommandId:Long = Long.getLong(158866586,759986797);
    private var _fireCommand_clientTimeCodec:ICodec;
    private var _fireStaticCommandId:Long = Long.getLong(1766359006,1664614075);
    private var _fireStaticCommand_clientTimeCodec:ICodec;
    private var _fireStaticCommand_hitPointCodec:ICodec;
    private var _fireTargetCommandId:Long = Long.getLong(1692205066,-158539970);
    private var _fireTargetCommand_clientTimeCodec:ICodec;
    private var _fireTargetCommand_targetCodec:ICodec;
    private var _fireTargetCommand_targetIncarnationCodec:ICodec;
    private var _fireTargetCommand_targetPositionCodec:ICodec;
    private var _fireTargetCommand_hitPointCodec:ICodec;
    private var _fireTargetCommand_hitPointWorldCodec:ICodec;
    private var model:IModel;

    public function SmokyModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._fireCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireStaticCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireStaticCommand_hitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._fireTargetCommand_clientTimeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._fireTargetCommand_targetCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._fireTargetCommand_targetIncarnationCodec = this.protocol.getCodec(new TypeCodecInfo(Short,false));
      this._fireTargetCommand_targetPositionCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._fireTargetCommand_hitPointCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._fireTargetCommand_hitPointWorldCodec = this.protocol.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function fireCommand(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._fireCommandId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function fireStaticCommand(param1:int, param2:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireStaticCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._fireStaticCommand_hitPointCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._fireStaticCommandId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function fireTargetCommand(param1:int, param2:IGameObject, param3:int, param4:Vector3d, param5:Vector3d, param6:Vector3d) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._fireTargetCommand_clientTimeCodec.encode(this.protocolBuffer,param1);
      this._fireTargetCommand_targetCodec.encode(this.protocolBuffer,param2);
      this._fireTargetCommand_targetIncarnationCodec.encode(this.protocolBuffer,param3);
      this._fireTargetCommand_targetPositionCodec.encode(this.protocolBuffer,param4);
      this._fireTargetCommand_hitPointCodec.encode(this.protocolBuffer,param5);
      this._fireTargetCommand_hitPointWorldCodec.encode(this.protocolBuffer,param6);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local7:SpaceCommand = new SpaceCommand(Model.object.id,this._fireTargetCommandId,this.protocolBuffer);
      var local8:IGameObject = Model.object;
      var local9:ISpace = local8.space;
      local9.commandSender.sendCommand(local7);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
