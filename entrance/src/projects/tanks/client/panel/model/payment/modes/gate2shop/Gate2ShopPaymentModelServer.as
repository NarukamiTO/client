package projects.tanks.client.panel.model.payment.modes.gate2shop {
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

  public class Gate2ShopPaymentModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _getPaymentUrlId:Long = Long.getLong(803840413,-1558470042);
    private var _getPaymentUrl_shopItemIdCodec:ICodec;
    private var _registerEmailAndGetPaymentUrlId:Long = Long.getLong(1842867688,985989084);
    private var _registerEmailAndGetPaymentUrl_shopItemIdCodec:ICodec;
    private var _registerEmailAndGetPaymentUrl_emailCodec:ICodec;
    private var _validateEmailId:Long = Long.getLong(1922004257,-611741631);
    private var _validateEmail_emailCodec:ICodec;
    private var model:IModel;

    public function Gate2ShopPaymentModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._getPaymentUrl_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._registerEmailAndGetPaymentUrl_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._registerEmailAndGetPaymentUrl_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._validateEmail_emailCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function getPaymentUrl(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._getPaymentUrl_shopItemIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._getPaymentUrlId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function registerEmailAndGetPaymentUrl(param1:Long, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._registerEmailAndGetPaymentUrl_shopItemIdCodec.encode(this.protocolBuffer,param1);
      this._registerEmailAndGetPaymentUrl_emailCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._registerEmailAndGetPaymentUrlId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function validateEmail(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._validateEmail_emailCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._validateEmailId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
