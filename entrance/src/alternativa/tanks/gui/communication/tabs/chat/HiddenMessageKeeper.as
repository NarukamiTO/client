package alternativa.tanks.gui.communication.tabs.chat {
  import alternativa.tanks.gui.chat.ChatOutputData;
  import flash.utils.Dictionary;

  public class HiddenMessageKeeper {
    private var hiddenChannels:Dictionary = new Dictionary();

    public function HiddenMessageKeeper() {
      super();
    }

    public function pushMessage(param1:String, param2:ChatOutputData) : void {
      if(!(param1 in this.hiddenChannels)) {
        this.hiddenChannels[param1] = new Vector.<ChatOutputData>();
      }
      this.hiddenChannels[param1].push(param2);
    }

    public function popMessages(param1:String) : Vector.<ChatOutputData> {
      var local2:Vector.<ChatOutputData> = this.hiddenChannels[param1];
      delete this.hiddenChannels[param1];
      return local2 != null ? local2 : new Vector.<ChatOutputData>();
    }

    public function cleanOutUsersMessages(param1:String) : void {
      var local2:Vector.<ChatOutputData> = null;
      var local3:Vector.<int> = null;
      var local4:int = 0;
      var local5:ChatOutputData = null;
      for each(local2 in this.hiddenChannels) {
        local3 = new Vector.<int>();
        local4 = 0;
        while(local4 < local2.length) {
          local5 = local2[local4] as ChatOutputData;
          if(local5.getSender().uid == param1) {
            local3.push(local4);
          }
          local4++;
        }
        local4 = local3.length - 1;
        while(local4 >= 0) {
          local2.splice(local3[local4],1);
          local4--;
        }
      }
    }
  }
}
