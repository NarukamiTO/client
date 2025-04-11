package projects.tanks.client.garage.models.garage.present {
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

  public class PresentPurchaseModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkUidId:Long = Long.getLong(1646969835,427146179);
    private var _checkUid_uidCodec:ICodec;
    private var _purchasePresentId:Long = Long.getLong(169296918,-2003348677);
    private var _purchasePresent_recipientUidCodec:ICodec;
    private var _purchasePresent_presentItemCodec:ICodec;
    private var _purchasePresent_textCodec:ICodec;
    private var _purchasePresent_expectedPriceCodec:ICodec;
    private var model:IModel;

    public function PresentPurchaseModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkUid_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._purchasePresent_recipientUidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._purchasePresent_presentItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._purchasePresent_textCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._purchasePresent_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
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

    public function purchasePresent(param1:String, param2:IGameObject, param3:String, param4:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._purchasePresent_recipientUidCodec.encode(this.protocolBuffer,param1);
      this._purchasePresent_presentItemCodec.encode(this.protocolBuffer,param2);
      this._purchasePresent_textCodec.encode(this.protocolBuffer,param3);
      this._purchasePresent_expectedPriceCodec.encode(this.protocolBuffer,param4);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local5:SpaceCommand = new SpaceCommand(Model.object.id,this._purchasePresentId,this.protocolBuffer);
      var local6:IGameObject = Model.object;
      var local7:ISpace = local6.space;
      local7.commandSender.sendCommand(local5);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
