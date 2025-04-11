package projects.tanks.client.entrance.model.entrance.changeuid {
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

  public class ChangeUidModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _changeUidId:Long = Long.getLong(247566950,622966367);
    private var _changeUid_emailCodec:ICodec;
    private var _changeUid_hashCodec:ICodec;
    private var _changeUid_newUidCodec:ICodec;
    private var _changeUidAndPasswordId:Long = Long.getLong(789349339,-796680627);
    private var _changeUidAndPassword_emailCodec:ICodec;
    private var _changeUidAndPassword_hashCodec:ICodec;
    private var _changeUidAndPassword_newUidCodec:ICodec;
    private var _changeUidAndPassword_passwordCodec:ICodec;
    private var _changeUidViaPartnerId:Long = Long.getLong(856618611,-953780377);
    private var _changeUidViaPartner_newUidCodec:ICodec;
    private var _checkChangeUidParamsId:Long = Long.getLong(1157412751,1480217791);
    private var _checkChangeUidParams_changeUidHashCodec:ICodec;
    private var _checkChangeUidParams_emailCodec:ICodec;
    private var model:IModel;

    public function ChangeUidModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._changeUid_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUid_hashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUid_newUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUidAndPassword_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUidAndPassword_hashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUidAndPassword_newUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUidAndPassword_passwordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeUidViaPartner_newUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._checkChangeUidParams_changeUidHashCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._checkChangeUidParams_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function changeUid(param1:String, param2:String, param3:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._changeUid_emailCodec.encode(this.protocolBuffer,param1);
      this._changeUid_hashCodec.encode(this.protocolBuffer,param2);
      this._changeUid_newUidCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._changeUidId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function changeUidAndPassword(param1:String, param2:String, param3:String, param4:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._changeUidAndPassword_emailCodec.encode(this.protocolBuffer,param1);
      this._changeUidAndPassword_hashCodec.encode(this.protocolBuffer,param2);
      this._changeUidAndPassword_newUidCodec.encode(this.protocolBuffer,param3);
      this._changeUidAndPassword_passwordCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._changeUidAndPasswordId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }

    public function changeUidViaPartner(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._changeUidViaPartner_newUidCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._changeUidViaPartnerId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function checkChangeUidParams(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkChangeUidParams_changeUidHashCodec.encode(this.protocolBuffer,param1);
      this._checkChangeUidParams_emailCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._checkChangeUidParamsId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
