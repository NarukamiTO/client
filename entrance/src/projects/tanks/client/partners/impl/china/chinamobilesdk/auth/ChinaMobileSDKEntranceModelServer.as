package projects.tanks.client.partners.impl.china.chinamobilesdk.auth {
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

  public class ChinaMobileSDKEntranceModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _loginId:Long = Long.getLong(538219146,1086364167);
    private var _login_authDataCodec:ICodec;
    private var _login_antiAddictionStateCodec:ICodec;
    private var model:IModel;

    public function ChinaMobileSDKEntranceModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._login_authDataCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._login_antiAddictionStateCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
    }

    public function login(param1:String, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._login_authDataCodec.encode(this.protocolBuffer,param1);
      this._login_antiAddictionStateCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._loginId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
