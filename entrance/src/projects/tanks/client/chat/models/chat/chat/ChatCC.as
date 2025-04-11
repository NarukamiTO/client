package projects.tanks.client.chat.models.chat.chat {
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class ChatCC {
    private var _admin:Boolean;
    private var _antifloodEnabled:Boolean;
    private var _bufferSize:int;
    private var _channels:Vector.<String>;
    private var _chatEnabled:Boolean;
    private var _chatModeratorLevel:ChatModeratorLevel;
    private var _linksWhiteList:Vector.<String>;
    private var _minChar:int;
    private var _minWord:int;
    private var _privateMessagesEnabled:Boolean;
    private var _selfName:String;
    private var _showLinks:Boolean;
    private var _typingSpeedAntifloodEnabled:Boolean;

    public function ChatCC(param1:Boolean = false, param2:Boolean = false, param3:int = 0, param4:Vector.<String> = null, param5:Boolean = false, param6:ChatModeratorLevel = null, param7:Vector.<String> = null, param8:int = 0, param9:int = 0, param10:Boolean = false, param11:String = null, param12:Boolean = false, param13:Boolean = false) {
      super();
      this._admin = param1;
      this._antifloodEnabled = param2;
      this._bufferSize = param3;
      this._channels = param4;
      this._chatEnabled = param5;
      this._chatModeratorLevel = param6;
      this._linksWhiteList = param7;
      this._minChar = param8;
      this._minWord = param9;
      this._privateMessagesEnabled = param10;
      this._selfName = param11;
      this._showLinks = param12;
      this._typingSpeedAntifloodEnabled = param13;
    }

    public function get admin() : Boolean {
      return this._admin;
    }

    public function set admin(param1:Boolean) : void {
      this._admin = param1;
    }

    public function get antifloodEnabled() : Boolean {
      return this._antifloodEnabled;
    }

    public function set antifloodEnabled(param1:Boolean) : void {
      this._antifloodEnabled = param1;
    }

    public function get bufferSize() : int {
      return this._bufferSize;
    }

    public function set bufferSize(param1:int) : void {
      this._bufferSize = param1;
    }

    public function get channels() : Vector.<String> {
      return this._channels;
    }

    public function set channels(param1:Vector.<String>) : void {
      this._channels = param1;
    }

    public function get chatEnabled() : Boolean {
      return this._chatEnabled;
    }

    public function set chatEnabled(param1:Boolean) : void {
      this._chatEnabled = param1;
    }

    public function get chatModeratorLevel() : ChatModeratorLevel {
      return this._chatModeratorLevel;
    }

    public function set chatModeratorLevel(param1:ChatModeratorLevel) : void {
      this._chatModeratorLevel = param1;
    }

    public function get linksWhiteList() : Vector.<String> {
      return this._linksWhiteList;
    }

    public function set linksWhiteList(param1:Vector.<String>) : void {
      this._linksWhiteList = param1;
    }

    public function get minChar() : int {
      return this._minChar;
    }

    public function set minChar(param1:int) : void {
      this._minChar = param1;
    }

    public function get minWord() : int {
      return this._minWord;
    }

    public function set minWord(param1:int) : void {
      this._minWord = param1;
    }

    public function get privateMessagesEnabled() : Boolean {
      return this._privateMessagesEnabled;
    }

    public function set privateMessagesEnabled(param1:Boolean) : void {
      this._privateMessagesEnabled = param1;
    }

    public function get selfName() : String {
      return this._selfName;
    }

    public function set selfName(param1:String) : void {
      this._selfName = param1;
    }

    public function get showLinks() : Boolean {
      return this._showLinks;
    }

    public function set showLinks(param1:Boolean) : void {
      this._showLinks = param1;
    }

    public function get typingSpeedAntifloodEnabled() : Boolean {
      return this._typingSpeedAntifloodEnabled;
    }

    public function set typingSpeedAntifloodEnabled(param1:Boolean) : void {
      this._typingSpeedAntifloodEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "ChatCC [";
      local1 += "admin = " + this.admin + " ";
      local1 += "antifloodEnabled = " + this.antifloodEnabled + " ";
      local1 += "bufferSize = " + this.bufferSize + " ";
      local1 += "channels = " + this.channels + " ";
      local1 += "chatEnabled = " + this.chatEnabled + " ";
      local1 += "chatModeratorLevel = " + this.chatModeratorLevel + " ";
      local1 += "linksWhiteList = " + this.linksWhiteList + " ";
      local1 += "minChar = " + this.minChar + " ";
      local1 += "minWord = " + this.minWord + " ";
      local1 += "privateMessagesEnabled = " + this.privateMessagesEnabled + " ";
      local1 += "selfName = " + this.selfName + " ";
      local1 += "showLinks = " + this.showLinks + " ";
      local1 += "typingSpeedAntifloodEnabled = " + this.typingSpeedAntifloodEnabled + " ";
      return local1 + "]";
    }
  }
}
