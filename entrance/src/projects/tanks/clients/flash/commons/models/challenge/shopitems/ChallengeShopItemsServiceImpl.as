package projects.tanks.clients.flash.commons.models.challenge.shopitems {
  import platform.client.fp10.core.type.IGameObject;

  public class ChallengeShopItemsServiceImpl implements ChallengeShopItems {
    private var _battlePass:IGameObject;
    private var _starsBundle:IGameObject;

    public function ChallengeShopItemsServiceImpl() {
      super();
    }

    public function get battlePass() : IGameObject {
      return this._battlePass;
    }

    public function set battlePass(param1:IGameObject) : void {
      this._battlePass = param1;
    }

    public function get starsBundle() : IGameObject {
      return this._starsBundle;
    }

    public function set starsBundle(param1:IGameObject) : void {
      this._starsBundle = param1;
    }
  }
}
