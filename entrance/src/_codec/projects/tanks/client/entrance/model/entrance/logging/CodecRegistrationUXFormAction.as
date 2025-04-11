package _codec.projects.tanks.client.entrance.model.entrance.logging {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXFormAction;

  public class CodecRegistrationUXFormAction implements ICodec {
    public function CodecRegistrationUXFormAction() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RegistrationUXFormAction = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = RegistrationUXFormAction.CORRECT_PASSWORD_TYPED;
          break;
        case 1:
          local2 = RegistrationUXFormAction.CORRECT_PASSWORD_CONFIRMATION_TYPED;
          break;
        case 2:
          local2 = RegistrationUXFormAction.CORRECT_USERNAME_TYPED;
          break;
        case 3:
          local2 = RegistrationUXFormAction.BUSY_USERNAME_TYPED;
          break;
        case 4:
          local2 = RegistrationUXFormAction.FORBIDDEN_USERNAME_TYPED;
          break;
        case 5:
          local2 = RegistrationUXFormAction.FORBIDDEN_CHARACTERS_TYPED;
          break;
        case 6:
          local2 = RegistrationUXFormAction.FORBIDDEN_LETTERS_TYPED;
          break;
        case 7:
          local2 = RegistrationUXFormAction.USERNAME_OFFER_ACCEPTED;
          break;
        case 8:
          local2 = RegistrationUXFormAction.SOCIAL_BUTTON_CLICKED;
          break;
        case 9:
          local2 = RegistrationUXFormAction.USER_AGREEMENT_ACCEPTED;
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
