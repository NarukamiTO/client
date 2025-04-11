package projects.tanks.client.entrance.model.entrance.logging {
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

  public class RegistrationUXLoggerModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _initLoggerId:Long = Long.getLong(935931399,2106694434);
    private var _initLogger_applicationStartTimeCodec:ICodec;
    private var _initLogger_fromTutorialCodec:ICodec;
    private var _initLogger_fromStandaloneTutorialCodec:ICodec;
    private var _logFormActionId:Long = Long.getLong(1150797508,-1436727392);
    private var _logFormAction_actionCodec:ICodec;
    private var _logFormAction_additionalCountCodec:ICodec;
    private var _logNavigationFinishId:Long = Long.getLong(255922434,49208013);
    private var _logNavigationStartId:Long = Long.getLong(423897558,-955922712);
    private var _logNavigationStart_destinationCodec:ICodec;
    private var model:IModel;

    public function RegistrationUXLoggerModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._initLogger_applicationStartTimeCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._initLogger_fromTutorialCodec = this.protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._initLogger_fromStandaloneTutorialCodec = this.protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._logFormAction_actionCodec = this.protocol.getCodec(new EnumCodecInfo(RegistrationUXFormAction,false));
      this._logFormAction_additionalCountCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._logNavigationStart_destinationCodec = this.protocol.getCodec(new EnumCodecInfo(RegistrationUXScreen,false));
    }

    public function initLogger(param1:String, param2:Boolean, param3:Boolean) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._initLogger_applicationStartTimeCodec.encode(this.protocolBuffer,param1);
      this._initLogger_fromTutorialCodec.encode(this.protocolBuffer,param2);
      this._initLogger_fromStandaloneTutorialCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._initLoggerId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function logFormAction(param1:RegistrationUXFormAction, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._logFormAction_actionCodec.encode(this.protocolBuffer,param1);
      this._logFormAction_additionalCountCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._logFormActionId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function logNavigationFinish() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._logNavigationFinishId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }

    public function logNavigationStart(param1:RegistrationUXScreen) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._logNavigationStart_destinationCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._logNavigationStartId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
