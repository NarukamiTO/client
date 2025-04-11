package projects.tanks.client.garage.models.garage {
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

  public class GarageModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _itemBoughtId:Long = Long.getLong(1116487489,1026874107);
    private var _itemBought_lightItemCodec:ICodec;
    private var _itemBought_countCodec:ICodec;
    private var _itemBought_expectedPriceCodec:ICodec;
    private var _itemMountedId:Long = Long.getLong(251373796,595500642);
    private var _itemMounted_itemCodec:ICodec;
    private var _itemUnmountedId:Long = Long.getLong(1052047932,-1451701093);
    private var _itemUnmounted_itemCodec:ICodec;
    private var _kitBoughtId:Long = Long.getLong(2042194585,-27577510);
    private var _kitBought_itemCodec:ICodec;
    private var _kitBought_expectedPriceCodec:ICodec;
    private var _readyToReloadId:Long = Long.getLong(508930523,-541032912);
    private var model:IModel;

    public function GarageModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._itemBought_lightItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._itemBought_countCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._itemBought_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._itemMounted_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._itemUnmounted_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._kitBought_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._kitBought_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function itemBought(param1:IGameObject, param2:int, param3:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._itemBought_lightItemCodec.encode(this.protocolBuffer,param1);
      this._itemBought_countCodec.encode(this.protocolBuffer,param2);
      this._itemBought_expectedPriceCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._itemBoughtId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function itemMounted(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._itemMounted_itemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._itemMountedId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function itemUnmounted(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._itemUnmounted_itemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._itemUnmountedId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function kitBought(param1:IGameObject, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._kitBought_itemCodec.encode(this.protocolBuffer,param1);
      this._kitBought_expectedPriceCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._kitBoughtId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function readyToReload() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._readyToReloadId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
