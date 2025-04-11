package alternativa.tanks.models.battle.gui.chat {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleChatAdapt implements IBattleChat {
    private var object:IGameObject;
    private var impl:IBattleChat;

    public function IBattleChatAdapt(param1:IGameObject, param2:IBattleChat) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getChat() : BattleChat {
      var result:BattleChat = null;
      try {
        Model.object = this.object;
        result = this.impl.getChat();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
