package projects.tanks.client.panel.model.payment.loader {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class PaymentLoaderModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _loadPaymentId:Long = Long.getLong(808015886,-1342372479);
    private var _loadPayment_shopCategoryCodec:ICodec;
    private var _loadPaymentWithGarageItemId:Long = Long.getLong(1673126377,2102802399);
    private var _loadPaymentWithGarageItem_itemCodec:ICodec;
    private var _loadPaymentWithShopItemId:Long = Long.getLong(945744032,-416977360);
    private var _loadPaymentWithShopItem_shopItemCodec:ICodec;
    private var model:IModel;

    public function PaymentLoaderModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._loadPayment_shopCategoryCodec = this.protocol.getCodec(new EnumCodecInfo(ShopCategoryEnum,false));
      this._loadPaymentWithGarageItem_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._loadPaymentWithShopItem_shopItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function loadPayment(param1:ShopCategoryEnum) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._loadPayment_shopCategoryCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._loadPaymentId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function loadPaymentWithGarageItem(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._loadPaymentWithGarageItem_itemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._loadPaymentWithGarageItemId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function loadPaymentWithShopItem(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._loadPaymentWithShopItem_shopItemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._loadPaymentWithShopItemId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
