package controls.dropdownlist {
  import flash.display.BitmapData;

  public class AccountsBackground extends DPLBackground {
    private static const bitmapBG:Class = AccountsBackground_bitmapBG;

    public function AccountsBackground() {
      super(100,275);
    }

    override protected function get bgBMP() : BitmapData {
      if(!_bgBMP) {
        _bgBMP = new bitmapBG().bitmapData;
      }
      return _bgBMP;
    }
  }
}
