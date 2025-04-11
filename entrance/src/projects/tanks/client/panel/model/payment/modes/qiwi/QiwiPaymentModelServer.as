package projects.tanks.client.panel.model.payment.modes.qiwi {
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

  public class QiwiPaymentModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _getPaymentUrlId:Long = Long.getLong(151087474,-1262705368);
    private var _getPaymentUrl_shopItemIdCodec:ICodec;
    private var _getPaymentUrl_phoneCodec:ICodec;
    private var model:IModel;

    public function QiwiPaymentModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._getPaymentUrl_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._getPaymentUrl_phoneCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function getPaymentUrl(param1:Long, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._getPaymentUrl_shopItemIdCodec.encode(this.protocolBuffer,param1);
      this._getPaymentUrl_phoneCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._getPaymentUrlId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
