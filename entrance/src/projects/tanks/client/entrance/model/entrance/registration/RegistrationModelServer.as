package projects.tanks.client.entrance.model.entrance.registration {
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

  public class RegistrationModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkUidId:Long = Long.getLong(458412608,-1323112141);
    private var _checkUid_uidCodec:ICodec;
    private var _registerId:Long = Long.getLong(458412513,903980216);
    private var _register_userUidCodec:ICodec;
    private var _register_passwordCodec:ICodec;
    private var _register_registeredUrlCodec:ICodec;
    private var _register_rememberMeCodec:ICodec;
    private var _register_referralHashCodec:ICodec;
    private var _register_realNameCodec:ICodec;
    private var _register_idNumberCodec:ICodec;
    private var _setFormerUserIdId:Long = Long.getLong(709671785,692586324);
    private var _setFormerUserId_formerUserIdCodec:ICodec;
    private var model:IModel;

    public function RegistrationModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkUid_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._register_userUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._register_passwordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._register_registeredUrlCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._register_rememberMeCodec = this.protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._register_referralHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._register_realNameCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._register_idNumberCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._setFormerUserId_formerUserIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function checkUid(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkUid_uidCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkUidId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._register_userUidCodec.encode(this.protocolBuffer,param1);
      this._register_passwordCodec.encode(this.protocolBuffer,param2);
      this._register_registeredUrlCodec.encode(this.protocolBuffer,param3);
      this._register_rememberMeCodec.encode(this.protocolBuffer,param4);
      this._register_referralHashCodec.encode(this.protocolBuffer,param5);
      this._register_realNameCodec.encode(this.protocolBuffer,param6);
      this._register_idNumberCodec.encode(this.protocolBuffer,param7);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local8:SpaceCommand = new SpaceCommand(Model.object.id,this._registerId,this.protocolBuffer);
      var local9:IGameObject = Model.object;
      var local10:ISpace = local9.space;
      local10.commandSender.sendCommand(local8);
      this.protocolBuffer.optionalMap.clear();
    }

    public function setFormerUserId(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._setFormerUserId_formerUserIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._setFormerUserIdId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
