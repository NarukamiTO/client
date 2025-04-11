package projects.tanks.client.entrance.model.entrance.email {
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

  public class EmailRegistrationModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkEmailId:Long = Long.getLong(1952335727,-1340357092);
    private var _checkEmail_emailCodec:ICodec;
    private var _registerUserRequiredEmailId:Long = Long.getLong(114502285,831250527);
    private var _registerUserRequiredEmail_userUidCodec:ICodec;
    private var _registerUserRequiredEmail_emailCodec:ICodec;
    private var _registerUserRequiredEmail_registeredUrlCodec:ICodec;
    private var _registerUserRequiredEmail_referralHashCodec:ICodec;
    private var _registerUserRequiredEmail_realNameCodec:ICodec;
    private var _registerUserRequiredEmail_idNumberCodec:ICodec;
    private var model:IModel;

    public function EmailRegistrationModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkEmail_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerUserRequiredEmail_userUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerUserRequiredEmail_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerUserRequiredEmail_registeredUrlCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerUserRequiredEmail_referralHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._registerUserRequiredEmail_realNameCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._registerUserRequiredEmail_idNumberCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function checkEmail(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkEmail_emailCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkEmailId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function registerUserRequiredEmail(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._registerUserRequiredEmail_userUidCodec.encode(this.protocolBuffer,param1);
      this._registerUserRequiredEmail_emailCodec.encode(this.protocolBuffer,param2);
      this._registerUserRequiredEmail_registeredUrlCodec.encode(this.protocolBuffer,param3);
      this._registerUserRequiredEmail_referralHashCodec.encode(this.protocolBuffer,param4);
      this._registerUserRequiredEmail_realNameCodec.encode(this.protocolBuffer,param5);
      this._registerUserRequiredEmail_idNumberCodec.encode(this.protocolBuffer,param6);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local7:SpaceCommand = new SpaceCommand(Model.object.id,this._registerUserRequiredEmailId,this.protocolBuffer);
      var local8:IGameObject = Model.object;
      var local9:ISpace = local8.space;
      local9.commandSender.sendCommand(local7);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
