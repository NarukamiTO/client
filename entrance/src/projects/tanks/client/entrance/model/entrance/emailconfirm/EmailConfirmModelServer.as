package projects.tanks.client.entrance.model.entrance.emailconfirm {
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

  public class EmailConfirmModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _confirmEmailId:Long = Long.getLong(1066290430,-1857025759);
    private var _confirmEmail_emailCodec:ICodec;
    private var _confirmEmail_emailConfirmHashCodec:ICodec;
    private var model:IModel;

    public function EmailConfirmModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._confirmEmail_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._confirmEmail_emailConfirmHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function confirmEmail(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._confirmEmail_emailCodec.encode(this.protocolBuffer,param1);
      this._confirmEmail_emailConfirmHashCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._confirmEmailId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
