package _codec.projects.tanks.client.entrance.model.entrance.logging {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXScreen;

  public class CodecRegistrationUXScreen implements ICodec {
    public function CodecRegistrationUXScreen() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RegistrationUXScreen = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = RegistrationUXScreen.MAIN;
          break;
        case 1:
          local2 = RegistrationUXScreen.VK;
          break;
        case 2:
          local2 = RegistrationUXScreen.FACEBOOK;
          break;
        case 3:
          local2 = RegistrationUXScreen.GOOGLE;
          break;
        case 4:
          local2 = RegistrationUXScreen.PARTNER;
          break;
        case 5:
          local2 = RegistrationUXScreen.LOGIN;
          break;
        case 6:
          local2 = RegistrationUXScreen.SITE;
          break;
        case 7:
          local2 = RegistrationUXScreen.TUTORIAL;
          break;
        case 8:
          local2 = RegistrationUXScreen.STANDALONE;
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
