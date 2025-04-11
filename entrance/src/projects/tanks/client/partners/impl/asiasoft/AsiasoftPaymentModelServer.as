package projects.tanks.client.partners.impl.asiasoft {
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

  public class AsiasoftPaymentModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkBalanceId:Long = Long.getLong(1295730514,-1432492069);
    private var _checkBalance_shopItemCodec:ICodec;
    private var _requestPaymentId:Long = Long.getLong(754337062,-1587724200);
    private var _requestPayment_shopItemIdCodec:ICodec;
    private var model:IModel;

    public function AsiasoftPaymentModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkBalance_shopItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._requestPayment_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function checkBalance(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkBalance_shopItemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkBalanceId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function requestPayment(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._requestPayment_shopItemIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._requestPaymentId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
