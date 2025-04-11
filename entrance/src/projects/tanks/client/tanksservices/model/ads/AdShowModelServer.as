package projects.tanks.client.tanksservices.model.ads {
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

  public class AdShowModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _logAdShowId:Long = Long.getLong(351351762,-24219482);
    private var _logAdShow_durationCodec:ICodec;
    private var _logAdShow_providerCodec:ICodec;
    private var _logAdShow_originCodec:ICodec;
    private var model:IModel;

    public function AdShowModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._logAdShow_durationCodec = this.protocol.getCodec(new TypeCodecInfo(Number,false));
      this._logAdShow_providerCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._logAdShow_originCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function logAdShow(param1:Number, param2:String, param3:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._logAdShow_durationCodec.encode(this.protocolBuffer,param1);
      this._logAdShow_providerCodec.encode(this.protocolBuffer,param2);
      this._logAdShow_originCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._logAdShowId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
