package projects.tanks.client.commons.models.captcha {
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

  public class CaptchaModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _checkCaptchaId:Long = Long.getLong(771266099,2094988130);
    private var _checkCaptcha_locationCodec:ICodec;
    private var _checkCaptcha_answerCodec:ICodec;
    private var _getNewCaptchaId:Long = Long.getLong(1715859709,2034952732);
    private var _getNewCaptcha_locationCodec:ICodec;
    private var model:IModel;

    public function CaptchaModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._checkCaptcha_locationCodec = this.protocol.getCodec(new EnumCodecInfo(CaptchaLocation,false));
      this._checkCaptcha_answerCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._getNewCaptcha_locationCodec = this.protocol.getCodec(new EnumCodecInfo(CaptchaLocation,false));
    }

    public function checkCaptcha(param1:CaptchaLocation, param2:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkCaptcha_locationCodec.encode(this.protocolBuffer,param1);
      this._checkCaptcha_answerCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._checkCaptchaId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function getNewCaptcha(param1:CaptchaLocation) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._getNewCaptcha_locationCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._getNewCaptchaId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
