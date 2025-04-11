package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.tanks.models.inventory.InventoryItemType;
  import flash.display.Bitmap;

  public class UltimateIcon extends InventoryIcons {
    private var ultimateIndex:int;

    public function UltimateIcon(param1:int) {
      this.ultimateIndex = param1;
      super(InventoryItemType.ULTIMATE);
    }

    override protected function getNeutralIcon(param1:int) : * {
      return new Bitmap(HudInventoryIcon.getUltimateIcon(this.ultimateIndex));
    }

    override protected function getEffectIcon(param1:int) : Bitmap {
      return new Bitmap(HudInventoryIcon.getUltimateIcon(this.ultimateIndex));
    }

    override protected function getCooldownIcon(param1:int) : Bitmap {
      return new Bitmap(HudInventoryIcon.getUltimateIcon(this.ultimateIndex));
    }
  }
}
