package _codec.projects.tanks.client.commons.models.captcha {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class CodecCaptchaLocation implements ICodec {
    public function CodecCaptchaLocation() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CaptchaLocation = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = CaptchaLocation.LOGIN_FORM;
          break;
        case 1:
          local2 = CaptchaLocation.REGISTER_FORM;
          break;
        case 2:
          local2 = CaptchaLocation.CLIENT_STARTUP;
          break;
        case 3:
          local2 = CaptchaLocation.RESTORE_PASSWORD_FORM;
          break;
        case 4:
          local2 = CaptchaLocation.EMAIL_CHANGE_HASH;
          break;
        case 5:
          local2 = CaptchaLocation.ACCOUNT_SETTINGS_FORM;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
