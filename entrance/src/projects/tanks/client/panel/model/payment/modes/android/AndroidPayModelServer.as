package projects.tanks.client.panel.model.payment.modes.android {
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

  public class AndroidPayModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkForConsumeTokensId:Long = Long.getLong(815792077,-1486947250);
    private var _checkForConsumeTokens_purchaseDataCodec:ICodec;
    private var _consumeSuccessId:Long = Long.getLong(1194773696,-1519770162);
    private var _consumeSuccess_tokenIdCodec:ICodec;
    private var _makePaymentId:Long = Long.getLong(1511923011,-1242214449);
    private var _makePayment_tokenIdCodec:ICodec;
    private var _makePayment_itemIdCodec:ICodec;
    private var _makePayment_currencyCodec:ICodec;
    private var model:IModel;

    public function AndroidPayModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkForConsumeTokens_purchaseDataCodec = this.protocol.getCodec(new TypeCodecInfo(PurchaseData,false));
      this._consumeSuccess_tokenIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._makePayment_tokenIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._makePayment_itemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._makePayment_currencyCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function checkForConsumeTokens(param1:PurchaseData) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkForConsumeTokens_purchaseDataCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkForConsumeTokensId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function consumeSuccess(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._consumeSuccess_tokenIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._consumeSuccessId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function makePayment(param1:String, param2:Long, param3:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._makePayment_tokenIdCodec.encode(this.protocolBuffer,param1);
      this._makePayment_itemIdCodec.encode(this.protocolBuffer,param2);
      this._makePayment_currencyCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._makePaymentId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
