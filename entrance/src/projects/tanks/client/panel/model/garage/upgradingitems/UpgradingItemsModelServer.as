package projects.tanks.client.panel.model.garage.upgradingitems {
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

  public class UpgradingItemsModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _itemUpgradedId:Long = Long.getLong(315970156,1555456153);
    private var _itemUpgraded_lightItemCodec:ICodec;
    private var _selectId:Long = Long.getLong(1964417151,-1180852710);
    private var _select_lightItemCodec:ICodec;
    private var model:IModel;

    public function UpgradingItemsModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._itemUpgraded_lightItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._select_lightItemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function itemUpgraded(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._itemUpgraded_lightItemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._itemUpgradedId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function select(param1:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._select_lightItemCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._selectId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
