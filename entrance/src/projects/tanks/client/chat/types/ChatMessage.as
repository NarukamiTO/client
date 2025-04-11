package projects.tanks.client.chat.types {
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;

  public class ChatMessage {
    private var _addressMode:ChatAddressMode;
    private var _battleLinks:Vector.<BattleChatLink>;
    private var _channel:String;
    private var _links:Vector.<String>;
    private var _messageType:MessageType;
    private var _sourceUser:UserStatus;
    private var _targetUser:UserStatus;
    private var _text:String;
    private var _timePassedInSec:int;

    public function ChatMessage(param1:ChatAddressMode = null, param2:Vector.<BattleChatLink> = null, param3:String = null, param4:Vector.<String> = null, param5:MessageType = null, param6:UserStatus = null, param7:UserStatus = null, param8:String = null, param9:int = 0) {
      super();
      this._addressMode = param1;
      this._battleLinks = param2;
      this._channel = param3;
      this._links = param4;
      this._messageType = param5;
      this._sourceUser = param6;
      this._targetUser = param7;
      this._text = param8;
      this._timePassedInSec = param9;
    }

    public function get addressMode() : ChatAddressMode {
      return this._addressMode;
    }

    public function set addressMode(param1:ChatAddressMode) : void {
      this._addressMode = param1;
    }

    public function get battleLinks() : Vector.<BattleChatLink> {
      return this._battleLinks;
    }

    public function set battleLinks(param1:Vector.<BattleChatLink>) : void {
      this._battleLinks = param1;
    }

    public function get channel() : String {
      return this._channel;
    }

    public function set channel(param1:String) : void {
      this._channel = param1;
    }

    public function get links() : Vector.<String> {
      return this._links;
    }

    public function set links(param1:Vector.<String>) : void {
      this._links = param1;
    }

    public function get messageType() : MessageType {
      return this._messageType;
    }

    public function set messageType(param1:MessageType) : void {
      this._messageType = param1;
    }

    public function get sourceUser() : UserStatus {
      return this._sourceUser;
    }

    public function set sourceUser(param1:UserStatus) : void {
      this._sourceUser = param1;
    }

    public function get targetUser() : UserStatus {
      return this._targetUser;
    }

    public function set targetUser(param1:UserStatus) : void {
      this._targetUser = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function get timePassedInSec() : int {
      return this._timePassedInSec;
    }

    public function set timePassedInSec(param1:int) : void {
      this._timePassedInSec = param1;
    }

    public function toString() : String {
      var local1:String = "ChatMessage [";
      local1 += "addressMode = " + this.addressMode + " ";
      local1 += "battleLinks = " + this.battleLinks + " ";
      local1 += "channel = " + this.channel + " ";
      local1 += "links = " + this.links + " ";
      local1 += "messageType = " + this.messageType + " ";
      local1 += "sourceUser = " + this.sourceUser + " ";
      local1 += "targetUser = " + this.targetUser + " ";
      local1 += "text = " + this.text + " ";
      local1 += "timePassedInSec = " + this.timePassedInSec + " ";
      return local1 + "]";
    }
  }
}
