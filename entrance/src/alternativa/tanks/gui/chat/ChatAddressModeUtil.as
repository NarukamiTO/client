package alternativa.tanks.gui.chat {
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;

  public class ChatAddressModeUtil {
    public static const PUBLIC_ADDRESS_MARKER:String = "; ";
    public static const PRIVATE_ADDRESS_MARKER:String = ": ";

    public function ChatAddressModeUtil() {
      super();
    }

    public static function getAddressMarker(param1:ChatAddressMode) : String {
      switch(param1) {
        case ChatAddressMode.PUBLIC_ADDRESSED:
          return PUBLIC_ADDRESS_MARKER;
        case ChatAddressMode.PRIVATE:
          return PRIVATE_ADDRESS_MARKER;
        default:
          return "";
      }
    }

    public static function parseAddressMode(param1:String) : ChatAddressMode {
      switch(param1) {
        case PUBLIC_ADDRESS_MARKER:
          return ChatAddressMode.PUBLIC_ADDRESSED;
        case PRIVATE_ADDRESS_MARKER:
          return ChatAddressMode.PRIVATE;
        default:
          return ChatAddressMode.PUBLIC_TO_ALL;
      }
    }

    public static function isPersonal(param1:ChatAddressMode) : Boolean {
      return param1 != ChatAddressMode.PUBLIC_TO_ALL;
    }
  }
}
