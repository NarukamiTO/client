package projects.tanks.client.entrance.model.entrance.partners {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class CompositePartnerModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _bindAccountId:Long = Long.getLong(1281188716,1940951489);
    private var _bindAccount_uidOrEmailCodec:ICodec;
    private var _bindAccount_passwordCodec:ICodec;
    private var _finishRegistrationId:Long = Long.getLong(148803981,-1046498619);
    private var _finishRegistration_uidCodec:ICodec;
    private var _finishRegistration_domainCodec:ICodec;
    private var _loadPartnerObjectOnClientId:Long = Long.getLong(1684542055,1718261084);
    private var _loadPartnerObjectOnClient_partnerIdCodec:ICodec;
    private var _loginViaPartnerId:Long = Long.getLong(1290469154,1689202484);
    private var _loginViaPartner_partnerIdCodec:ICodec;
    private var _loginViaPartner_urlParamsCodec:ICodec;
    private var model:IModel;

    public function CompositePartnerModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._bindAccount_uidOrEmailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._bindAccount_passwordCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._finishRegistration_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._finishRegistration_domainCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._loadPartnerObjectOnClient_partnerIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._loginViaPartner_partnerIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._loginViaPartner_urlParamsCodec = this.protocol.getCodec(new TypeCodecInfo(LoginParameters,false));
    }

    public function bindAccount(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._bindAccount_uidOrEmailCodec.encode(this.protocolBuffer,param1);
      this._bindAccount_passwordCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._bindAccountId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function finishRegistration(param1:String, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._finishRegistration_uidCodec.encode(this.protocolBuffer,param1);
      this._finishRegistration_domainCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._finishRegistrationId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function loadPartnerObjectOnClient(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._loadPartnerObjectOnClient_partnerIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._loadPartnerObjectOnClientId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function loginViaPartner(param1:String, param2:LoginParameters) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._loginViaPartner_partnerIdCodec.encode(this.protocolBuffer,param1);
      this._loginViaPartner_urlParamsCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._loginViaPartnerId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
