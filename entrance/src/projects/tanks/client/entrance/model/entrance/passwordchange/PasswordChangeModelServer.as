package projects.tanks.client.entrance.model.entrance.passwordchange {
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

  public class PasswordChangeModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _changePasswordAndEmailId:Long = Long.getLong(1096951772,-398910379);
    private var _changePasswordAndEmail_changePasswordHashCodec:ICodec;
    private var _changePasswordAndEmail_newPasswordCodec:ICodec;
    private var _changePasswordAndEmail_newEmailCodec:ICodec;
    private var _checkPasswordChangeHashId:Long = Long.getLong(1886402857,829134628);
    private var _checkPasswordChangeHash_changePasswordHashCodec:ICodec;
    private var _resetChangePasswordHashAndEntranceHashId:Long = Long.getLong(423051391,-1887006664);
    private var _resetChangePasswordHashAndEntranceHash_changePasswordHashCodec:ICodec;
    private var _sendUsersRestorePasswordLinkId:Long = Long.getLong(1519457675,1374102424);
    private var _sendUsersRestorePasswordLink_emailCodec:ICodec;
    private var model:IModel;

    public function PasswordChangeModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._changePasswordAndEmail_changePasswordHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changePasswordAndEmail_newPasswordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changePasswordAndEmail_newEmailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._checkPasswordChangeHash_changePasswordHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._resetChangePasswordHashAndEntranceHash_changePasswordHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._sendUsersRestorePasswordLink_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function changePasswordAndEmail(param1:String, param2:String, param3:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._changePasswordAndEmail_changePasswordHashCodec.encode(this.protocolBuffer,param1);
      this._changePasswordAndEmail_newPasswordCodec.encode(this.protocolBuffer,param2);
      this._changePasswordAndEmail_newEmailCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._changePasswordAndEmailId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function checkPasswordChangeHash(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkPasswordChangeHash_changePasswordHashCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkPasswordChangeHashId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function resetChangePasswordHashAndEntranceHash(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._resetChangePasswordHashAndEntranceHash_changePasswordHashCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._resetChangePasswordHashAndEntranceHashId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function sendUsersRestorePasswordLink(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._sendUsersRestorePasswordLink_emailCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._sendUsersRestorePasswordLinkId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
