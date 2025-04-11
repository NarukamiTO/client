package alternativa.tanks.gui.chat {
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;

  public class ChatOutputData {
    private var sender:UserStatus;
    private var receiver:UserStatus;
    private var addressMode:ChatAddressMode;
    private var text:String;
    private var messageType:MessageType;
    private var html:Boolean;

    public function ChatOutputData(param1:UserStatus, param2:UserStatus, param3:ChatAddressMode, param4:String, param5:MessageType, param6:Boolean) {
      super();
      this.sender = param1;
      this.receiver = param2;
      this.addressMode = param3;
      this.text = param4;
      this.messageType = param5;
      this.html = param6;
    }

    public function getSender() : UserStatus {
      return this.sender;
    }

    public function getReceiver() : UserStatus {
      return this.receiver;
    }

    public function getAddressMode() : ChatAddressMode {
      return this.addressMode;
    }

    public function getText() : String {
      return this.text;
    }

    public function getMessageType() : MessageType {
      return this.messageType;
    }

    public function isHtml() : Boolean {
      return this.html;
    }
  }
}
