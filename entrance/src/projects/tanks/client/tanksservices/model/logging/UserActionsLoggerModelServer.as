package projects.tanks.client.tanksservices.model.logging {
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
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.tanksservices.model.logging.battlelist.BattleSelectAction;
  import projects.tanks.client.tanksservices.model.logging.gamescreen.GameScreen;
  import projects.tanks.client.tanksservices.model.logging.garage.GarageAction;
  import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;

  public class UserActionsLoggerModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _battleSelectActionId:Long = Long.getLong(1183039361,-338785851);
    private var _battleSelectAction_actionCodec:ICodec;
    private var _battleSelectAction_modeCodec:ICodec;
    private var _battleSelectAction_additionalInfoCodec:ICodec;
    private var _changeScreenActionId:Long = Long.getLong(200512566,311968605);
    private var _changeScreenAction_previousScreenCodec:ICodec;
    private var _changeScreenAction_currentScreenCodec:ICodec;
    private var _garageActionId:Long = Long.getLong(1180610968,-1146396686);
    private var _garageAction_actionCodec:ICodec;
    private var _garageAction_itemCodec:ICodec;
    private var _paymentActionId:Long = Long.getLong(587263982,69409237);
    private var _paymentAction_paymentActionCodec:ICodec;
    private var _paymentAction_layoutNameCodec:ICodec;
    private var _paymentAction_countryCodeCodec:ICodec;
    private var _paymentAction_payModeIdCodec:ICodec;
    private var _paymentAction_shopItemIdCodec:ICodec;
    private var _settingsActionId:Long = Long.getLong(444375215,-1877779402);
    private var _settingsAction_settingsCodec:ICodec;
    private var model:IModel;

    public function UserActionsLoggerModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._battleSelectAction_actionCodec = this.protocol.getCodec(new EnumCodecInfo(BattleSelectAction,false));
      this._battleSelectAction_modeCodec = this.protocol.getCodec(new EnumCodecInfo(BattleMode,false));
      this._battleSelectAction_additionalInfoCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._changeScreenAction_previousScreenCodec = this.protocol.getCodec(new EnumCodecInfo(GameScreen,false));
      this._changeScreenAction_currentScreenCodec = this.protocol.getCodec(new EnumCodecInfo(GameScreen,false));
      this._garageAction_actionCodec = this.protocol.getCodec(new EnumCodecInfo(GarageAction,false));
      this._garageAction_itemCodec = this.protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._paymentAction_paymentActionCodec = this.protocol.getCodec(new EnumCodecInfo(PaymentAction,false));
      this._paymentAction_layoutNameCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._paymentAction_countryCodeCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._paymentAction_payModeIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._paymentAction_shopItemIdCodec = this.protocol.getCodec(new TypeCodecInfo(String,true));
      this._settingsAction_settingsCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function battleSelectAction(param1:BattleSelectAction, param2:BattleMode, param3:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._battleSelectAction_actionCodec.encode(this.protocolBuffer,param1);
      this._battleSelectAction_modeCodec.encode(this.protocolBuffer,param2);
      this._battleSelectAction_additionalInfoCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._battleSelectActionId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function changeScreenAction(param1:GameScreen, param2:GameScreen) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._changeScreenAction_previousScreenCodec.encode(this.protocolBuffer,param1);
      this._changeScreenAction_currentScreenCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._changeScreenActionId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function garageAction(param1:GarageAction, param2:IGameObject) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._garageAction_actionCodec.encode(this.protocolBuffer,param1);
      this._garageAction_itemCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._garageActionId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function paymentAction(param1:PaymentAction, param2:String, param3:String, param4:String, param5:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._paymentAction_paymentActionCodec.encode(this.protocolBuffer,param1);
      this._paymentAction_layoutNameCodec.encode(this.protocolBuffer,param2);
      this._paymentAction_countryCodeCodec.encode(this.protocolBuffer,param3);
      this._paymentAction_payModeIdCodec.encode(this.protocolBuffer,param4);
      this._paymentAction_shopItemIdCodec.encode(this.protocolBuffer,param5);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local6:SpaceCommand = new SpaceCommand(Model.object.id,this._paymentActionId,this.protocolBuffer);
      var local7:IGameObject = Model.object;
      var local8:ISpace = local7.space;
      local8.commandSender.sendCommand(local6);
      this.protocolBuffer.optionalMap.clear();
    }

    public function settingsAction(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._settingsAction_settingsCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._settingsActionId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
