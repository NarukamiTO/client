package projects.tanks.client.garage.models.garage.upgrade {
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

  public class UpgradeGarageItemModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _instantUpgradeId:Long = Long.getLong(352299153,1189456555);
    private var _instantUpgrade_itemCodec:ICodec;
    private var _instantUpgrade_numLevelsCodec:ICodec;
    private var _instantUpgrade_expectedPriceCodec:ICodec;
    private var _speedUpId:Long = Long.getLong(691265024,-2084377048);
    private var _speedUp_itemCodec:ICodec;
    private var _speedUp_expectedPriceCodec:ICodec;
    private var _upgradeItemId:Long = Long.getLong(1876823160,-33493301);
    private var _upgradeItem_itemCodec:ICodec;
    private var _upgradeItem_expectedPriceCodec:ICodec;
    private var _upgradeItem_expectedTimeInSecondsCodec:ICodec;
    private var model:IModel;

    public function UpgradeGarageItemModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._instantUpgrade_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._instantUpgrade_numLevelsCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._instantUpgrade_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._speedUp_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._speedUp_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._upgradeItem_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._upgradeItem_expectedPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._upgradeItem_expectedTimeInSecondsCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function instantUpgrade(param1:IGameObject, param2:int, param3:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._instantUpgrade_itemCodec.encode(this.protocolBuffer,param1);
      this._instantUpgrade_numLevelsCodec.encode(this.protocolBuffer,param2);
      this._instantUpgrade_expectedPriceCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._instantUpgradeId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function speedUp(param1:IGameObject, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._speedUp_itemCodec.encode(this.protocolBuffer,param1);
      this._speedUp_expectedPriceCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._speedUpId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function upgradeItem(param1:IGameObject, param2:int, param3:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._upgradeItem_itemCodec.encode(this.protocolBuffer,param1);
      this._upgradeItem_expectedPriceCodec.encode(this.protocolBuffer,param2);
      this._upgradeItem_expectedTimeInSecondsCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._upgradeItemId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
