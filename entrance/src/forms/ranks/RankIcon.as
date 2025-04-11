package forms.ranks {
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.errors.IllegalOperationError;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class RankIcon extends DiscreteSprite {
    [Inject]
    public static var rankService:RankService;

    private var hasPremium:Boolean = false;
    private var rankIcon:Bitmap;

    public function RankIcon() {
      super();
    }

    public function setRank(param1:int) : void {
      if(this.hasPremium) {
        this.setPremium(param1);
      } else {
        this.setDefaultAccount(param1);
      }
    }

    public function setPremium(param1:int) : void {
      this.hasPremium = true;
      this.setBitmap(this.createPremiumRankBitmap(param1));
    }

    public function setDefaultAccount(param1:int) : void {
      this.hasPremium = false;
      this.setBitmap(this.createDefaultRankBitmap(param1));
    }

    private function setBitmap(param1:Bitmap) : void {
      removeDisplayObject(this.rankIcon);
      addChild(this.rankIcon = param1);
    }

    public function init(param1:Boolean, param2:int) : void {
      param2 = int(rankService.getNormalizedRankIndex(param2));
      if(param1) {
        this.setPremium(param2);
      } else {
        this.setDefaultAccount(param2);
      }
    }

    protected function createDefaultRankBitmap(param1:int) : Bitmap {
      throw new IllegalOperationError();
    }

    protected function createPremiumRankBitmap(param1:int) : Bitmap {
      throw new IllegalOperationError();
    }
  }
}
