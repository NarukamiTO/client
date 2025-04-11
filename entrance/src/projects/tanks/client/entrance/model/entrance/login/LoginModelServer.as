package projects.tanks.client.entrance.model.entrance.login {
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

  public class LoginModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _loginId:Long = Long.getLong(25286687,-1924305606);
    private var _login_uidOrEmailCodec:ICodec;
    private var _login_passwordCodec:ICodec;
    private var _login_rememberCodec:ICodec;
    private var model:IModel;

    public function LoginModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._login_uidOrEmailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._login_passwordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._login_rememberCodec = this.protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function login(param1:String, param2:String, param3:Boolean) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._login_uidOrEmailCodec.encode(this.protocolBuffer,param1);
      this._login_passwordCodec.encode(this.protocolBuffer,param2);
      this._login_rememberCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._loginId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
