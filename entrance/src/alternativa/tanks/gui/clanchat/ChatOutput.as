package alternativa.tanks.gui.clanchat {
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.utils.setTimeout;
  import forms.userlabel.ChatUpdateEvent;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
  import projects.tanks.client.chat.types.MessageType;
  import projects.tanks.client.chat.types.UserStatus;

  public class ChatOutput extends ScrollPane {
    private static const MAX_MESSAGES:int = 80;

    public var wasScrolled:Boolean;
    public var deltaWidth:int = 9;
    public var selfUid:String;

    private var container:Sprite = new Sprite();
    private var lineWidth:Number;
    private var _showIPMode:Boolean = false;
    private var updateIntervalId:uint = 0;

    public function ChatOutput() {
      super();
      this.source = this.container;
      this.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.focusEnabled = false;
      this.container.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
    }

    public function addLine(param1:UserStatus, param2:UserStatus, param3:ChatAddressMode, param4:String, param5:Date, param6:MessageType = null, param7:Boolean = false, param8:Boolean = true) : void {
      var local9:Boolean = false;
      if(param8) {
        local9 = verticalScrollPosition + 5 > maxVerticalScrollPosition || !this.wasScrolled;
      }
      if(this.container.numChildren > MAX_MESSAGES) {
        this.shiftMessages();
      }
      var local10:ChatOutputLine = new ChatOutputLine(this.lineWidth,param1,param2,param3,param4,param5,param6,param7,this.selfUid);
      local10.showIP = this._showIPMode;
      local10.self = local10.userNameTo == this.selfUid;
      local10.y = int(this.container.height + 0.5);
      this.container.addChild(local10);
      update();
      if(local9) {
        this.scrollDown();
      }
    }

    public function scrollDown() : void {
      verticalScrollPosition = maxVerticalScrollPosition;
    }

    public function highlightUids(param1:String) : void {
      var local2:int = 0;
      while(local2 < this.container.numChildren) {
        this.highlightLine(this.container.getChildAt(local2) as ChatOutputLine,param1);
        local2++;
      }
    }

    public function highlightUidsInLastMessage(param1:String) : void {
      if(this.container.numChildren > 0) {
        this.highlightLine(this.container.getChildAt(this.container.numChildren - 1) as ChatOutputLine,param1);
      }
    }

    private function highlightLine(param1:ChatOutputLine, param2:String) : void {
      param1.light = param1.userName == param2 || param1.addressMode == ChatAddressMode.PUBLIC_ADDRESSED && param1.userNameTo == this.selfUid;
      param1.self = param1.userNameTo == this.selfUid && param1.addressMode == ChatAddressMode.PRIVATE;
    }

    private function shiftMessages() : void {
      var local1:ChatOutputLine = this.container.getChildAt(0) as ChatOutputLine;
      var local2:Number = local1.height + local1.y;
      this.container.removeChild(local1);
      var local3:int = 0;
      while(local3 < this.container.numChildren) {
        this.container.getChildAt(local3).y = this.container.getChildAt(local3).y - local2;
        local3++;
      }
    }

    override public function setSize(param1:Number, param2:Number) : void {
      super.setSize(param1,param2);
      this.lineWidth = param1 - this.deltaWidth;
      this.updateLines();
    }

    private function onUpdateEvent(param1:ChatUpdateEvent) : void {
      if(this.updateIntervalId == 0) {
        this.updateIntervalId = setTimeout(this.updateLines,500);
      }
    }

    private function updateLines() : void {
      var local2:ChatOutputLine = null;
      var local3:ChatOutputLine = null;
      this.updateIntervalId = 0;
      if(this.container.numChildren == 0) {
        return;
      }
      var local1:Vector.<ChatOutputLine> = new Vector.<ChatOutputLine>();
      while(this.container.numChildren > 0) {
        local3 = this.container.getChildAt(0) as ChatOutputLine;
        local3.showIP = this._showIPMode;
        local3.width = this.lineWidth;
        local1.push(local3);
        this.container.removeChildAt(0);
      }
      for each(local2 in local1) {
        local2.y = int(this.container.height + 0.5);
        this.container.addChild(local2);
      }
      update();
    }

    public function cleanOutUsersMessages(param1:String) : void {
      var local4:ChatOutputLine = null;
      var local2:Vector.<ChatOutputLine> = new Vector.<ChatOutputLine>();
      var local3:int = 0;
      while(local3 < this.container.numChildren) {
        local4 = this.container.getChildAt(local3) as ChatOutputLine;
        if(local4.userName == param1) {
          local2.push(local4);
        }
        local3++;
      }
      local3 = 0;
      while(local3 < local2.length) {
        this.container.removeChild(local2[local3]);
        local3++;
      }
      this.updateLines();
    }

    public function set showIPMode(param1:Boolean) : void {
      this._showIPMode = param1;
      this.updateLines();
    }
  }
}
