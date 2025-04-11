package projects.tanks.client.entrance.model.entrance.externalentrance {
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

  public class ExternalEntranceModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _createLinkForExistingUserId:Long = Long.getLong(585546371,-672024828);
    private var _createLinkForExistingUser_uidOrEmailCodec:ICodec;
    private var _createLinkForExistingUser_passwordCodec:ICodec;
    private var _registerNewUserId:Long = Long.getLong(603440169,-914721987);
    private var _registerNewUser_uidCodec:ICodec;
    private var _registerNewUser_referralHashCodec:ICodec;
    private var _setLoginDataId:Long = Long.getLong(828747821,-1429059850);
    private var _setLoginData_rememberMeCodec:ICodec;
    private var _setLoginData_domainCodec:ICodec;
    private var model:IModel;

    public function ExternalEntranceModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._createLinkForExistingUser_uidOrEmailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._createLinkForExistingUser_passwordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerNewUser_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerNewUser_referralHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._setLoginData_rememberMeCodec = this.protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._setLoginData_domainCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function createLinkForExistingUser(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._createLinkForExistingUser_uidOrEmailCodec.encode(this.protocolBuffer,param1);
      this._createLinkForExistingUser_passwordCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._createLinkForExistingUserId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function registerNewUser(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._registerNewUser_uidCodec.encode(this.protocolBuffer,param1);
      this._registerNewUser_referralHashCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._registerNewUserId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function setLoginData(param1:Boolean, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._setLoginData_rememberMeCodec.encode(this.protocolBuffer,param1);
      this._setLoginData_domainCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._setLoginDataId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
