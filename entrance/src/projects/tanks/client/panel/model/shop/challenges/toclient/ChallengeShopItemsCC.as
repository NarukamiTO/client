package projects.tanks.client.panel.model.shop.challenges.toclient {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public class ChallengeShopItemsCC {
    private var _shopBattlePass:IGameObject;
    private var _shopBattlePassId:Long;
    private var _starsBundle:IGameObject;
    private var _starsBundleId:Long;

    public function ChallengeShopItemsCC(param1:IGameObject = null, param2:Long = null, param3:IGameObject = null, param4:Long = null) {
      super();
      this._shopBattlePass = param1;
      this._shopBattlePassId = param2;
      this._starsBundle = param3;
      this._starsBundleId = param4;
    }

    public function get shopBattlePass() : IGameObject {
      return this._shopBattlePass;
    }

    public function set shopBattlePass(param1:IGameObject) : void {
      this._shopBattlePass = param1;
    }

    public function get shopBattlePassId() : Long {
      return this._shopBattlePassId;
    }

    public function set shopBattlePassId(param1:Long) : void {
      this._shopBattlePassId = param1;
    }

    public function get starsBundle() : IGameObject {
      return this._starsBundle;
    }

    public function set starsBundle(param1:IGameObject) : void {
      this._starsBundle = param1;
    }

    public function get starsBundleId() : Long {
      return this._starsBundleId;
    }

    public function set starsBundleId(param1:Long) : void {
      this._starsBundleId = param1;
    }

    public function toString() : String {
      var local1:String = "ChallengeShopItemsCC [";
      local1 += "shopBattlePass = " + this.shopBattlePass + " ";
      local1 += "shopBattlePassId = " + this.shopBattlePassId + " ";
      local1 += "starsBundle = " + this.starsBundle + " ";
      local1 += "starsBundleId = " + this.starsBundleId + " ";
      return local1 + "]";
    }
  }
}
