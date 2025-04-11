package forms.ranks {
  import flash.display.Bitmap;

  public class BigRankIcon extends RankIcon {
    public function BigRankIcon() {
      super();
    }

    override protected function createDefaultRankBitmap(param1:int) : Bitmap {
      return new Bitmap(DefaultRanksBitmaps.bigRanks[param1 - 1]);
    }

    override protected function createPremiumRankBitmap(param1:int) : Bitmap {
      return new Bitmap(PremiumRankBitmaps.bigRanks[param1 - 1]);
    }
  }
}
