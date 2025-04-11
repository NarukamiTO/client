package forms.ranks {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class SmallRankIcon extends RankIcon {
    private static const nullRankIcon:Bitmap = new Bitmap(new BitmapData(1,1));

    public function SmallRankIcon(param1:int = 1) {
      super();
      setDefaultAccount(param1);
    }

    override protected function createDefaultRankBitmap(param1:int) : Bitmap {
      if(param1 <= 0 || param1 > DefaultRanksBitmaps.smallRanks.length) {
        return nullRankIcon;
      }
      return new Bitmap(DefaultRanksBitmaps.smallRanks[param1 - 1]);
    }

    override protected function createPremiumRankBitmap(param1:int) : Bitmap {
      if(param1 <= 0 || param1 > PremiumRankBitmaps.smallRanks.length) {
        return nullRankIcon;
      }
      return new Bitmap(PremiumRankBitmaps.smallRanks[param1 - 1]);
    }
  }
}
