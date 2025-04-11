package projects.tanks.client.commons.models.captcha {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class CaptchaModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:CaptchaModelServer;

    private var client:ICaptchaModelBase = ICaptchaModelBase(this);
    private var modelId:Long = Long.getLong(490831193,1530810385);
    private var _captchaCorrectId:Long = Long.getLong(1163794707,1156292692);
    private var _captchaCorrect_stateCodec:ICodec;
    private var _captchaFailedId:Long = Long.getLong(176089096,-444205293);
    private var _captchaFailed_stateCodec:ICodec;
    private var _captchaFailed_newCaptchaCodec:ICodec;
    private var _showCaptchaId:Long = Long.getLong(1404540170,-251744121);
    private var _showCaptcha_stateCodec:ICodec;
    private var _showCaptcha_captchaCodec:ICodec;

    public function CaptchaModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new CaptchaModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(CaptchaCC,false)));
      this._captchaCorrect_stateCodec = this._protocol.getCodec(new EnumCodecInfo(CaptchaLocation,false));
      this._captchaFailed_stateCodec = this._protocol.getCodec(new EnumCodecInfo(CaptchaLocation,false));
      this._captchaFailed_newCaptchaCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,1));
      this._showCaptcha_stateCodec = this._protocol.getCodec(new EnumCodecInfo(CaptchaLocation,false));
      this._showCaptcha_captchaCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,1));
    }

    protected function getInitParam() : CaptchaCC {
      return CaptchaCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._captchaCorrectId:
          this.client.captchaCorrect(CaptchaLocation(this._captchaCorrect_stateCodec.decode(param2)));
          break;
        case this._captchaFailedId:
          this.client.captchaFailed(CaptchaLocation(this._captchaFailed_stateCodec.decode(param2)),this._captchaFailed_newCaptchaCodec.decode(param2) as Vector.<int>);
          break;
        case this._showCaptchaId:
          this.client.showCaptcha(CaptchaLocation(this._showCaptcha_stateCodec.decode(param2)),this._showCaptcha_captchaCodec.decode(param2) as Vector.<int>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
