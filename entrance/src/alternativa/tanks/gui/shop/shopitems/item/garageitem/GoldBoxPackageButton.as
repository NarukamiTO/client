package alternativa.tanks.gui.shop.shopitems.item.garageitem {
  import alternativa.tanks.gui.shop.shopitems.item.CountableItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.LeftPictureAndTextPackageButton;
  import alternativa.tanks.model.payment.shop.goldbox.GoldBoxPackage;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class GoldBoxPackageButton extends LeftPictureAndTextPackageButton implements CountableItemButton {
    public function GoldBoxPackageButton(param1:IGameObject) {
      super(param1);
    }

    override protected function getText() : String {
      return this.getBoxWordDeclension(this.getCount()).toLowerCase();
    }

    private function getBoxWordDeclension(param1:int) : String {
      return param1.toString() + " " + this.getDeclension(param1);
    }

    private function getDeclension(param1:int) : String {
      if(localeService.language == "ru") {
        return localeService.getText(TanksLocale.TEXT_SHOP_GOLDBOX_ONE) + this.getRuPostfix(param1);
      }
      return localeService.getText(param1 == 1 ? TanksLocale.TEXT_SHOP_GOLDBOX_ONE : TanksLocale.TEXT_SHOP_GOLDBOX_MANY);
    }

    private function getRuPostfix(param1:int) : String {
      var local2:int = param1 % 100;
      if(local2 >= 11 && local2 <= 20) {
        return "ов";
      }
      local2 = param1 % 10;
      if(local2 == 1) {
        return "";
      }
      if(local2 >= 2 && local2 <= 4) {
        return "а";
      }
      return "ов";
    }

    public function getCount() : int {
      return GoldBoxPackage(item.adapt(GoldBoxPackage)).getCount();
    }

    override protected function getNameLabelFontSize() : int {
      switch(localeService.language) {
        case "fa":
          return 26;
        default:
          return super.getNameLabelFontSize();
      }
    }
  }
}
