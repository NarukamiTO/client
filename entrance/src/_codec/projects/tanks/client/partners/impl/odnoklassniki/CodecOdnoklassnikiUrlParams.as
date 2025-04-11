package _codec.projects.tanks.client.partners.impl.odnoklassniki {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.partners.impl.odnoklassniki.OdnoklassnikiUrlParams;

  public class CodecOdnoklassnikiUrlParams implements ICodec {
    public function CodecOdnoklassnikiUrlParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:OdnoklassnikiUrlParams = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = OdnoklassnikiUrlParams.API_SERVER;
          break;
        case 1:
          local2 = OdnoklassnikiUrlParams.APICONNECTION;
          break;
        case 2:
          local2 = OdnoklassnikiUrlParams.APPLICATION_KEY;
          break;
        case 3:
          local2 = OdnoklassnikiUrlParams.AUTH_SIG;
          break;
        case 4:
          local2 = OdnoklassnikiUrlParams.AUTHORIZED;
          break;
        case 5:
          local2 = OdnoklassnikiUrlParams.CONTAINER;
          break;
        case 6:
          local2 = OdnoklassnikiUrlParams.CUSTOM_ARGS;
          break;
        case 7:
          local2 = OdnoklassnikiUrlParams.FIRST_START;
          break;
        case 8:
          local2 = OdnoklassnikiUrlParams.HEADER_WIDGET;
          break;
        case 9:
          local2 = OdnoklassnikiUrlParams.LOGGED_USER_ID;
          break;
        case 10:
          local2 = OdnoklassnikiUrlParams.REFERER;
          break;
        case 11:
          local2 = OdnoklassnikiUrlParams.REFPLACE;
          break;
        case 12:
          local2 = OdnoklassnikiUrlParams.SESSION_KEY;
          break;
        case 13:
          local2 = OdnoklassnikiUrlParams.SESSION_SECRET_KEY;
          break;
        case 14:
          local2 = OdnoklassnikiUrlParams.SIG;
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
