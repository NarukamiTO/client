package projects.tanks.client.panel.model.payment.modes.platbox {
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

  public class PlatBoxPaymentModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkNumberId:Long = Long.getLong(1361382183,1178132338);
    private var _checkNumber_phoneCodec:ICodec;
    private var _initPaymentId:Long = Long.getLong(1360199342,1271010061);
    private var _initPayment_phoneCodec:ICodec;
    private var _initPayment_shopItemIdCodec:ICodec;
    private var model:IModel;

    public function PlatBoxPaymentModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkNumber_phoneCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._initPayment_phoneCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._initPayment_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function checkNumber(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkNumber_phoneCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkNumberId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function initPayment(param1:String, param2:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._initPayment_phoneCodec.encode(this.protocolBuffer,param1);
      this._initPayment_shopItemIdCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._initPaymentId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
