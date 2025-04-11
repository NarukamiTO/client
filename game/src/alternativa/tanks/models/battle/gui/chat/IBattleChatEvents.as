package alternativa.tanks.models.battle.gui.chat {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleChatEvents implements IBattleChat {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBattleChatEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getChat() : BattleChat {
      var result:BattleChat = null;
      var i:int = 0;
      var m:IBattleChat = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleChat(this.impl[i]);
          result = m.getChat();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
